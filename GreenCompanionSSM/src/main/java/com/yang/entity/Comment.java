package com.yang.entity;

import java.util.Date;

public class Comment {
    private Integer id;
    private Integer plantId;
    private Integer userId;
    private String username;
    private String content;
    private Date createTime;

    // Getter + Setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getPlantId() { return plantId; }
    public void setPlantId(Integer plantId) { this.plantId = plantId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}