package com.yang.mapper;

import com.yang.entity.AdoptApply;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import java.util.List;

public interface AdoptApplyMapper {

    @Insert("INSERT INTO tb_adopt_apply (target_plant_id, apply_user_id, apply_reason, apply_time, audit_status) " +
            "VALUES (#{plant_id}, #{user_id}, #{reason}, #{apply_time}, #{status})")
    void saveApply(AdoptApply apply);

    @Select("SELECT " +
            "apply_id, " +
            "target_plant_id AS plant_id, " +
            "apply_user_id AS user_id, " +
            "apply_reason AS reason, " +
            "apply_time, " +
            "audit_status AS status " +
            "FROM tb_adopt_apply")
    List<AdoptApply> getAllApplies();

    // 核心修改：这里改为 #{user_id} 以匹配实体类的属性
    @Select("SELECT " +
            "apply_id, " +
            "target_plant_id AS plant_id, " +
            "apply_user_id AS user_id, " +
            "apply_reason AS reason, " +
            "apply_time, " +
            "audit_status AS status " +
            "FROM tb_adopt_apply WHERE apply_user_id = #{user_id}")
    List<AdoptApply> getAppliesByUserId(Integer user_id); // 参数名改为user_id

    @Update("UPDATE tb_adopt_apply SET audit_status = #{status} WHERE apply_id = #{applyId}")
    void updateStatus(@Param("applyId") Integer applyId, @Param("status") String status);
}