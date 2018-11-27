package com.baizhi.cmfz.controller;

import com.baizhi.cmfz.service.MenusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/menus")
public class MenusController {

    @Autowired
    private MenusService menusService;

    @RequestMapping("/selectAll")
    public Map selectAll(){
        return menusService.selectAll();
    }
}
