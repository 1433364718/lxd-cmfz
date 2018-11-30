package com.baizhi.cmfz.controller;

import com.baizhi.cmfz.entity.Album;
import com.baizhi.cmfz.service.AlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/album")
public class AlbumController {

    @Autowired
    private AlbumService albumService;

    @RequestMapping("/show")
    public @ResponseBody Map show(){
        return albumService.show();
    }

    @RequestMapping("/add")
    public @ResponseBody boolean add(Album album, MultipartFile uploadFile, HttpServletRequest req) throws IOException {
        // 获取上传的文件的名字
        String fileName = uploadFile.getOriginalFilename();

        // 通过uuid获取新名字
        String newFileName = UUID.randomUUID().toString()+fileName.substring(fileName.lastIndexOf("."));

        //1.获取文件夹的相对路径
        String realPath = req.getSession().getServletContext().getRealPath("/img");

        //2.file对象（上传到项目的productImages文件夹中）
        File file = new File(realPath+"\\"+newFileName);
        //3.写入
        uploadFile.transferTo(file);

        album.setCoverImg(newFileName);
        album.setPublishDate(new Date());

        try {
            albumService.add(album);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }


        return false;
    }
}
