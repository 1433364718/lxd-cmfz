package com.baizhi.cmfz.dao;

import com.baizhi.cmfz.entity.Album;

import java.util.List;

public interface AlbumDao {
    int getCount();

    List<Album> show();

    void add(Album album);
}
