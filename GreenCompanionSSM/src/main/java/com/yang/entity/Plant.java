package com.yang.entity;

// 绿植实体类：和数据库tb_plant_info表字段一一对应
public class Plant {
    private Integer plant_id;       // 绿植ID
    private String plant_name;      // 绿植名称
    private String plant_type;      // 绿植类型
    private String current_status;  // 绿植状态（待领养/已领养）

    // ========== 新增字段（匹配数据库新增的字段） ==========
    private String plant_desc;      // 绿植描述（对应数据库plant_desc）
    private String plant_img;       // 绿植图片URL（对应数据库plant_img）
    // ====================================================

    // 原有字段的 Getter/Setter 方法（保留）
    public Integer getPlant_id() {
        return plant_id;
    }

    public void setPlant_id(Integer plant_id) {
        this.plant_id = plant_id;
    }

    public String getPlant_name() {
        return plant_name;
    }

    public void setPlant_name(String plant_name) {
        this.plant_name = plant_name;
    }

    public String getPlant_type() {
        return plant_type;
    }

    public void setPlant_type(String plant_type) {
        this.plant_type = plant_type;
    }

    public String getCurrent_status() {
        return current_status;
    }

    public void setCurrent_status(String current_status) {
        this.current_status = current_status;
    }

    // ========== 新增字段的 Getter/Setter 方法（关键！） ==========
    public String getPlant_desc() {
        return plant_desc;
    }

    public void setPlant_desc(String plant_desc) {
        this.plant_desc = plant_desc;
    }

    public String getPlant_img() {
        return plant_img;
    }

    public void setPlant_img(String plant_img) {
        this.plant_img = plant_img;
    }
    // ===========================================================
}