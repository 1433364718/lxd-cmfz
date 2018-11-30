package com.baizhi.cmfz.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Data
public class Album {
    private int id;
    private String title;
    private String coverImg;
    private int count;

    // 评价
    private double score;
    private String author;

    // 播音
    private String broadcast;

    // 内容
    private String brief;
    @JSONField(format = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date publishDate;
    private List<Chapter>  children;
}
