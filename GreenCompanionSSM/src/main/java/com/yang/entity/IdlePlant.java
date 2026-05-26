package com.yang.entity;

// 闲置绿植交换实体类（匹配tb_idle_plant表）
public class IdlePlant {
    private Integer idle_id;       // 主键ID
    private Integer user_id;       // 发布用户ID
    private String plant_name;     // 绿植名称
    private String plant_type;     // 绿植类型
    private String description;    // 描述（交换要求/绿植状态）
    private String publish_time;   // 发布时间
    private String username;       // 发布用户名（冗余字段，方便展示）

    // 空参构造
    public IdlePlant() {}

    // Getter/Setter
    public Integer getIdle_id() { return idle_id; }
    public void setIdle_id(Integer idle_id) { this.idle_id = idle_id; }
    public Integer getUser_id() { return user_id; }
    public void setUser_id(Integer user_id) { this.user_id = user_id; }
    public String getPlant_name() { return plant_name; }
    public void setPlant_name(String plant_name) { this.plant_name = plant_name; }
    public String getPlant_type() { return plant_type; }
    public void setPlant_type(String plant_type) { this.plant_type = plant_type; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getPublish_time() { return publish_time; }
    public void setPublish_time(String publish_time) { this.publish_time = publish_time; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
}