package com.yang.mapper;
import com.yang.entity.IdlePlant;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import java.util.List;

public interface IdlePlantMapper {
    // 和Service/Controller保持一致：方法名addIdlePlant
    @Insert("INSERT INTO tb_idle_plant (user_id, plant_name, plant_type, description, publish_time, username) " +
            "VALUES (#{user_id}, #{plant_name}, #{plant_type}, #{description}, #{publish_time}, #{username})")
    int addIdlePlant(IdlePlant idlePlant);

    // 查询所有闲置绿植
    @Select("SELECT * FROM tb_idle_plant")
    List<IdlePlant> getAllIdlePlants();

    // 查询我的闲置绿植（参数名@Param("user_id")和Service一致）
    @Select("SELECT * FROM tb_idle_plant WHERE user_id = #{user_id}")
    List<IdlePlant> getMyIdlePlants(@Param("user_id") Integer user_id);
}