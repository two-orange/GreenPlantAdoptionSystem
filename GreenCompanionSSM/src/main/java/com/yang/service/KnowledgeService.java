package com.yang.service;

import com.yang.entity.Knowledge;
import com.yang.mapper.KnowledgeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class KnowledgeService {
    @Autowired
    private KnowledgeMapper knowledgeMapper;

    // 原有：查询所有养护知识（保留不动）
    public List<Knowledge> getAllKnowledge() {
        return knowledgeMapper.getAllKnowledge();
    }

    // 原有：根据ID查询单条知识（保留不动）
    public Knowledge getKnowledgeById(Integer knowledge_id) {
        return knowledgeMapper.getKnowledgeById(knowledge_id);
    }

    // 新增：更新养护知识（标题+内容）
    public boolean updateKnowledge(Knowledge knowledge) {
        // 调用Mapper的更新方法，返回受影响行数 > 0 则更新成功
        int rows = knowledgeMapper.updateKnowledge(knowledge);
        return rows > 0;
    }
}