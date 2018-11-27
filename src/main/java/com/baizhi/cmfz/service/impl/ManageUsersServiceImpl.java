package com.baizhi.cmfz.service.impl;

import com.baizhi.cmfz.dao.ManageUsersDao;
import com.baizhi.cmfz.entity.ManageUsers;
import com.baizhi.cmfz.service.ManageUsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ManageUsersServiceImpl implements ManageUsersService {

    @Autowired
    private ManageUsersDao manageUsersDao;

    @Override
    public ManageUsers login(ManageUsers manageUsers) {
        return manageUsersDao.login(manageUsers);
    }
}
