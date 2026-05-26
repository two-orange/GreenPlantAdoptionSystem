package com.yang.service;

import com.yang.mapper.DataStatsMapper;
import com.yang.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
public class DataStatsService {

    @Autowired
    private DataStatsMapper dataStatsMapper;

    // 用户活跃度统计
    public List<UserActiveVO> getUserActiveStats() {
        return dataStatsMapper.selectUserActiveStats();
    }

    // 绿植趋势（领养/交换）
    public List<PlantTrendVO> getPlantTrendStats() {
        return dataStatsMapper.selectPlantTrendStats();
    }

    // 全局基础统计
    public Map<String, Object> getTotalBaseStats() {
        return dataStatsMapper.selectTotalBaseStats();
    }
}