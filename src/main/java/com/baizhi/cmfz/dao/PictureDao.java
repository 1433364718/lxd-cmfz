package com.baizhi.cmfz.dao;

import com.baizhi.cmfz.entity.Picture;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PictureDao {
    List<Picture> selectByPage(@Param("start") int start, @Param("rows") Integer rows);
    int getCount();

    void add(Picture picture);

    void delete(int id);

    void update(Picture picture);
}
