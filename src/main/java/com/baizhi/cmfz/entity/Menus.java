package com.baizhi.cmfz.entity;

import lombok.Data;

import java.util.List;

@Data
public class Menus {
    private int id;
    private String title;
    private  String iconCls;
    private int parentId;
    private String url;
    private List<Menus> menuList;
}
