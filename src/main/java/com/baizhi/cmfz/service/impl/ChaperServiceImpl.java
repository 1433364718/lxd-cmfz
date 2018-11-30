package com.baizhi.cmfz.service.impl;

import com.baizhi.cmfz.dao.ChapterDao;
import com.baizhi.cmfz.entity.Chapter;
import com.baizhi.cmfz.service.ChaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ChaperServiceImpl implements ChaperService {
    @Autowired
    private ChapterDao chapterDao;
    @Override
    public void add(Chapter chapter) {
        chapterDao.add(chapter);
    }
}
