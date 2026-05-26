package com.yang.service;

import com.yang.entity.AdoptApply;
import com.yang.mapper.AdoptApplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AdoptApplyService {

    @Autowired
    private AdoptApplyMapper adoptApplyMapper;

    // 保存领养申请
    public void saveApply(AdoptApply apply) {
        adoptApplyMapper.saveApply(apply);
    }

    // 管理员查询所有申请
    public List<AdoptApply> getAllApplies() {
        return adoptApplyMapper.getAllApplies();
    }

    // 普通用户查询自己的申请
    public List<AdoptApply> getAppliesByUserId(Integer userId) {
        return adoptApplyMapper.getAppliesByUserId(userId);
    }

    // 管理员更新审核状态
    public void updateStatus(Integer applyId, String status) {
        adoptApplyMapper.updateStatus(applyId, status);
    }
}