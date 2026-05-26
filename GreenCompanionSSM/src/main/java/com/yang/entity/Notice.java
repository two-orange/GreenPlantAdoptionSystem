package com.yang.entity;
import java.util.Date;

public class Notice {
    private Integer id;
    private Integer userId;
    private String content;
    private Integer readStatus;
    private Date createTime;

    // getter + setter
    public Integer getId() {return id;}
    public void setId(Integer id) {this.id = id;}
    public Integer getUserId() {return userId;}
    public void setUserId(Integer userId) {this.userId = userId;}
    public String getContent() {return content;}
    public void setContent(String content) {this.content = content;}
    public Integer getReadStatus() {return readStatus;}
    public void setReadStatus(Integer readStatus) {this.readStatus = readStatus;}
    public Date getCreateTime() {return createTime;}
    public void setCreateTime(Date createTime) {this.createTime = createTime;}
}