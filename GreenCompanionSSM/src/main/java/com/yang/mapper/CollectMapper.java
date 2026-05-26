package com.yang.mapper;

import com.yang.entity.Plant;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import java.util.List;

public interface CollectMapper {

    // 添加收藏
    @Insert("INSERT INTO user_collect(user_id, plant_id, create_time) VALUES(#{userId}, #{plantId}, NOW())")
    int addCollect(@Param("userId") Integer userId, @Param("plantId") Integer plantId);

    // 取消收藏
    @Delete("DELETE FROM user_collect WHERE user_id = #{userId} AND plant_id = #{plantId}")
    int deleteCollect(@Param("userId") Integer userId, @Param("plantId") Integer plantId);

    // 判断是否已经收藏
    @Select("SELECT COUNT(*) FROM user_collect WHERE user_id = #{userId} AND plant_id = #{plantId}")
    int isCollectExist(@Param("userId") Integer userId, @Param("plantId") Integer plantId);

    // ✅ 完全匹配你数据库的正确SQL：表名 tb_plant_info，主键 plant_id
    @Select("SELECT p.* FROM tb_plant_info p INNER JOIN user_collect c ON p.plant_id = c.plant_id WHERE c.user_id = #{userId}")
    List<Plant> getMyCollect(@Param("userId") Integer userId);
}