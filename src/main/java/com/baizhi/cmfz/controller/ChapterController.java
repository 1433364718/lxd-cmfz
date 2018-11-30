package com.baizhi.cmfz.controller;

import com.baizhi.cmfz.entity.Chapter;
import com.baizhi.cmfz.service.ChaperService;
import com.baizhi.cmfz.util.FileUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.Date;
import java.util.UUID;

@Controller
@RequestMapping("/chapter")
public class ChapterController {
    @Autowired
    private ChaperService chaperService;

    @RequestMapping("/add")
    public @ResponseBody boolean add(MultipartFile chapterFile, Chapter chapter, HttpServletRequest req) throws IOException {
        // 获取上传的文件的名字
        String fileName = chapterFile.getOriginalFilename();

        // 获取文件大小
        long si = chapterFile.getSize();
        // 换算成MB,取两位小数
        double size = si/1024.0/1024.0;
        BigDecimal b = new BigDecimal(size);
        double f1 = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();

        // 通过uuid获取新名字
        String newFileName = UUID.randomUUID().toString()+fileName.substring(fileName.lastIndexOf("."));

        //1.获取文件夹的相对路径
        String realPath = req.getSession().getServletContext().getRealPath("/chapter");

        //2.file对象（上传到项目的productImages文件夹中）
        File file = new File(realPath+"\\"+newFileName);
        //3.写入
        chapterFile.transferTo(file);
        // 获取时长(秒)
        int duration = FileUtil.getDuration(file);
        // 把时长转换成分
        int fen = duration/60;
        int miao = duration%60;

        chapter.setTitle(fileName.substring(0,fileName.lastIndexOf(".")));
        chapter.setDownPath(newFileName);
        chapter.setSize(f1+"Mb");
        chapter.setDuration(fen+"分"+miao+"秒");

        chapter.setId(UUID.randomUUID().toString());
        chapter.setUploadDate(new Date());
        System.out.println(chapter);
        try {
            chaperService.add(chapter);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @RequestMapping("/dowload")
    public @ResponseBody void dowload(String title, String url, HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 到文件存放位置读取文件
        String path = request.getSession().getServletContext().getRealPath("chapter");
        File file = new File(path+"/"+url);


        try {
            // 解决下载中文乱码的问题，做编码处理。以附件的形式响应给客户端
            String aa = URLEncoder.encode(title, "utf-8");
            String newName = aa+ url.substring(url.lastIndexOf("."));
            response.setHeader("Content-Disposition", "attachment;filename=" + newName);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        // 设置格式为mp3
        response.setContentType("audio/mpeg");

        FileUtils.copyFile(file,response.getOutputStream());

    }

}
