package com.yang.vo;

public class UserActiveVO {
    private Integer id;
    private String username;
    private String phone;
    private Integer totalNotice;
    private Integer readNotice;

    // 手动生成 getter/setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public Integer getTotalNotice() { return totalNotice; }
    public void setTotalNotice(Integer totalNotice) { this.totalNotice = totalNotice; }
    public Integer getReadNotice() { return readNotice; }
    public void setReadNotice(Integer readNotice) { this.readNotice = readNotice; }
}