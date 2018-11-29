package com.baizhi.cmfz.service;

import com.baizhi.cmfz.entity.Picture;

import java.util.Map;

public interface PictureService {
    public Map selectByPage(Integer page,Integer rows);

    void add(Picture picture);

    void delete(int id);

    void update(Picture picture);
}
