package com.baizhi.cmfz.service;

import com.baizhi.cmfz.entity.Album;

import java.util.Map;

public interface AlbumService {
    Map show();

    void add(Album album);
}
