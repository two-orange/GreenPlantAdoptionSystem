package com.yang.service;

import com.yang.entity.Plant;
import java.util.List;

public interface CollectService {
    int addCollect(Integer userId, Integer plantId);
    int deleteCollect(Integer userId, Integer plantId);
    int isCollectExist(Integer userId, Integer plantId);
    List<Plant> getMyCollect(Integer userId);
}