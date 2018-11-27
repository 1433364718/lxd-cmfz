package com.baizhi.cmfz.controller;

import com.baizhi.cmfz.entity.ManageUsers;
import com.baizhi.cmfz.service.ManageUsersService;
import com.google.code.kaptcha.Producer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;

@Controller
@RequestMapping("/manage")
public class ManageUsersController {
    @Autowired
    private ManageUsersService manageUsersService;

    @Autowired
    private Producer producer;

    @RequestMapping("/getKaptcha")
    public void getKaptcha(HttpSession session, HttpServletResponse response) throws IOException {

        String text = producer.createText();
        session.setAttribute("yzm", text);

        BufferedImage image = producer.createImage(text);

        ImageIO.write(image,"jpg",response.getOutputStream());

    }

    @RequestMapping("/login")
    public String login(String yanZhengMa, HttpSession session, ManageUsers manageUsers){

        String  yzm = (String) session.getAttribute("yzm");

        if(yzm.equalsIgnoreCase(yanZhengMa)){
            ManageUsers us = manageUsersService.login(manageUsers);
            if(us==null){
                return "redirect:/login.jsp";
            }else{
                session.setAttribute("manage",us);
                return "redirect:/main/main.jsp";
            }
        }
        return "redirect:/login.jsp";
    }
}
