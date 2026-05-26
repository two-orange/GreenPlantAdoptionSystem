package com.yang.service;

import com.yang.entity.IdlePlant;
import com.yang.mapper.IdlePlantMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Date;
import java.text.SimpleDateFormat;

@Service
public class IdlePlantService {
    @Autowired
    private IdlePlantMapper idlePlantMapper;

    // 和Controller保持一致：方法名addIdlePlant
    public boolean addIdlePlant(IdlePlant idlePlant) {
        // 自动填充发布时间（格式：2026-03-15 10:00）
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        idlePlant.setPublish_time(sdf.format(new Date()));
        // 调用Mapper的addIdlePlant方法（必须和Mapper命名一致）
        int rows = idlePlantMapper.addIdlePlant(idlePlant);
        return rows > 0; // 返回true表示发布成功
    }

    // 查询所有闲置绿植（命名一致）
    public List<IdlePlant> getAllIdlePlants() {
        return idlePlantMapper.getAllIdlePlants();
    }

    // 查询我的闲置绿植（参数名user_id和Mapper一致）
    public List<IdlePlant> getMyIdlePlants(Integer user_id) {
        return idlePlantMapper.getMyIdlePlants(user_id);
    }
}