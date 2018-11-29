package com.baizhi.cmfz.service.impl;

import com.baizhi.cmfz.dao.PictureDao;
import com.baizhi.cmfz.entity.Picture;
import com.baizhi.cmfz.service.PictureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class PictureServiceImpl implements PictureService {

    @Autowired
    private PictureDao pictureDao;

    @Override
    public Map selectByPage(Integer page, Integer rows){
        Map map = new HashMap();
        int start = rows*(page-1);

        List<Picture> pictureList = pictureDao.selectByPage(start,rows);
        int total = pictureDao.getCount();
        map.put("rows",pictureList);
        map.put("total",total);
        return map;
    }

    @Override
    public void add(Picture picture) {
        pictureDao.add(picture);
    }

    @Override
    public void delete(int id) {
        pictureDao.delete(id);
    }

    @Override
    public void update(Picture picture) {
        pictureDao.update(picture);
    }
}
