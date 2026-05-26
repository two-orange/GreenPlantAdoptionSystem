package com.yang.mapper;

import com.yang.entity.Knowledge;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update; // 新增：导入Update注解
import java.util.List;

public interface KnowledgeMapper {
    // 原有：查询所有养护知识（保留不动）
    @Select("SELECT * FROM tb_knowledge")
    List<Knowledge> getAllKnowledge();

    // 原有：根据ID查询单条知识（保留不动）
    @Select("SELECT * FROM tb_knowledge WHERE knowledge_id = #{knowledge_id}")
    Knowledge getKnowledgeById(Integer knowledge_id);

    // 新增：更新养护知识（标题+内容）
    @Update("UPDATE tb_knowledge SET title = #{title}, content = #{content} WHERE knowledge_id = #{knowledge_id}")
    int updateKnowledge(Knowledge knowledge);
}