package com.baizhi.cmfz.service.impl;

import com.baizhi.cmfz.dao.MenusDao;
import com.baizhi.cmfz.entity.Menus;
import com.baizhi.cmfz.service.MenusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenusServiceImpl implements MenusService {

    @Autowired
    private MenusDao menusDao;


    @Override
    public Map selectAll() {
        Map map = new HashMap();
        map.put("menusList",menusDao.selectAll());
        for (Menus o : menusDao.selectAll()) {
            System.out.println(o);
        }
        return map;
    }
}
