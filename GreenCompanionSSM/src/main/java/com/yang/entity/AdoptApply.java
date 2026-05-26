package com.yang.entity;

public class AdoptApply {
    private Integer apply_id;
    private Integer plant_id;
    private Integer user_id;
    // 核心新增：reason 字段（对应前端申请理由、数据库表字段）
    private String reason;
    private String apply_time;
    private String status; // 待审核/已通过/已拒绝

    public AdoptApply() {}

    // 构造方法也要新增 reason 参数（可选，但建议补全）
    public AdoptApply(Integer apply_id, Integer plant_id, Integer user_id, String reason, String apply_time, String status) {
        this.apply_id = apply_id;
        this.plant_id = plant_id;
        this.user_id = user_id;
        this.reason = reason; // 新增
        this.apply_time = apply_time;
        this.status = status;
    }

    // Getter/Setter（核心：新增 reason 的 get/set 方法）
    public Integer getApply_id() { return apply_id; }
    public void setApply_id(Integer apply_id) { this.apply_id = apply_id; }
    public Integer getPlant_id() { return plant_id; }
    public void setPlant_id(Integer plant_id) { this.plant_id = plant_id; }
    public Integer getUser_id() { return user_id; }
    public void setUser_id(Integer user_id) { this.user_id = user_id; }

    // 核心新增：reason 的 getter
    public String getReason() { return reason; }
    // 核心新增：reason 的 setter
    public void setReason(String reason) { this.reason = reason; }

    public String getApply_time() { return apply_time; }
    public void setApply_time(String apply_time) { this.apply_time = apply_time; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}