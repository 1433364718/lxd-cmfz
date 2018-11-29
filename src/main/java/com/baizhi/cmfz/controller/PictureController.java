package com.baizhi.cmfz.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baizhi.cmfz.entity.Picture;
import com.baizhi.cmfz.service.PictureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
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
@RequestMapping("/picture")
public class PictureController {

    @Autowired
    private PictureService pictureService;
    @RequestMapping("/selectByPage")
    public @ResponseBody Map selectByPage(Integer page,Integer rows){
        return pictureService.selectByPage(page,rows);
    }

    @RequestMapping("/update")
    public @ResponseBody boolean update(Picture picture){
        try {
            pictureService.update(picture);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @RequestMapping("/add")
    public @ResponseBody boolean add(MultipartFile uploadFile, HttpServletRequest req,Picture picture) throws IOException {
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
        picture.setUrl(newFileName);
        picture.setDate(new Date());
        picture.setStatus("展示");
        try {
            pictureService.add(picture);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    @RequestMapping("/delete")
    public @ResponseBody boolean delete(int id){
        try {
            pictureService.delete(id);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
