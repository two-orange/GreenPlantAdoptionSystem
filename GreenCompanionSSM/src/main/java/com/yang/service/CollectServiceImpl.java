package com.yang.service;

import com.yang.entity.Plant;
import com.yang.mapper.CollectMapper;
import com.yang.service.CollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CollectServiceImpl implements CollectService {

    @Autowired
    private CollectMapper collectMapper;

    @Override
    public int addCollect(Integer userId, Integer plantId) {
        return collectMapper.addCollect(userId, plantId);
    }

    @Override
    public int deleteCollect(Integer userId, Integer plantId) {
        return collectMapper.deleteCollect(userId, plantId);
    }

    @Override
    public int isCollectExist(Integer userId, Integer plantId) {
        return collectMapper.isCollectExist(userId, plantId);
    }

    @Override
    public List<Plant> getMyCollect(Integer userId) {
        return collectMapper.getMyCollect(userId);
    }
}