package com.yang.mapper;

import com.yang.entity.Plant;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.Param; // 新增：导入@Param注解
import java.util.List;

public interface PlantMapper {

    // 查询所有绿植（表名改为 tb_plant_info，匹配你的数据库）
    @Select("SELECT * FROM tb_plant_info")
    List<Plant> selectAllPlants();

    // 根据ID查询绿植（表名改为 tb_plant_info，字段用 plant_id 匹配你的表）
    @Select("SELECT * FROM tb_plant_info WHERE plant_id = #{plantId}")
    Plant getPlantById(Integer plantId);

    // ========== 新增：按名称模糊查询待领养绿植（核心适配搜索功能） ==========
    @Select("SELECT * FROM tb_plant_info WHERE plant_name LIKE #{keyword} AND current_status = '待领养'")
    List<Plant> getPlantsByNameLike(String keyword);
    // ===============================================================

    // 新增绿植（补充plant_desc/plant_img字段，匹配新增页面输入框）
    @Insert("INSERT INTO tb_plant_info(plant_name, plant_type, plant_desc, plant_img, current_status) " +
            "VALUES(#{plant_name}, #{plant_type}, #{plant_desc}, #{plant_img}, #{current_status})")
    void insertPlant(Plant plant);

    // 根据ID删除绿植（添加@Param注解，解决参数绑定报错）
    @Delete("DELETE FROM tb_plant_info WHERE plant_id = #{id}")
    void deletePlantById(@Param("id") Integer id);

    // 编辑绿植（更新所有字段，匹配编辑页面）
    @Update("UPDATE tb_plant_info SET plant_name=#{plant_name}, plant_type=#{plant_type}, " +
            "plant_desc=#{plant_desc}, plant_img=#{plant_img}, current_status=#{current_status} " +
            "WHERE plant_id=#{plant_id}")
    void updatePlant(Plant plant);
}