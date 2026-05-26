package com.yang.service;

import com.yang.entity.Plant;
import com.yang.mapper.PlantMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PlantService {

    @Autowired
    private PlantMapper plantMapper;

    // 1. 查询所有绿植（通用）
    public List<Plant> getAllPlants() {
        return plantMapper.selectAllPlants();
    }

    // 2. 根据ID查询单株绿植（用于申请页展示）
    public Plant getPlantById(Integer plantId) {
        return plantMapper.getPlantById(plantId);
    }

    // 3. 查询待领养绿植（和 getAllPlants 逻辑一致，适配 Controller 命名）
    public List<Plant> getAdoptPlants() {
        return plantMapper.selectAllPlants();
    }

    // ========== 新增：按名称模糊查询待领养绿植 ==========
    public List<Plant> getPlantsByNameLike(String keyword) {
        return plantMapper.getPlantsByNameLike(keyword);
    }
    // ===================================================

    // 4. 新增绿植（适配 Controller 的 addPlant）
    public void addPlant(Plant plant) {
        plantMapper.insertPlant(plant);
    }

    // 5. 删除绿植（适配 Controller 的 deletePlant）
    public void deletePlant(Integer id) {
        plantMapper.deletePlantById(id);
    }
    public void updatePlant(Plant plant) {
        plantMapper.updatePlant(plant);
    }
}