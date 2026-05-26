package com.yang.entity;

// 用户实体类：匹配数据库用户表，区分普通用户/管理员
public class User {
    private Integer user_id;        // 用户ID（主键）
    private String username;        // 用户名
    private String password;        // 密码
    private String role;            // 角色：user（普通用户）/ admin（管理员）
    // ========== 新增字段 ==========
    private String phone;           // 手机号（个人信息用）
    private String address;         // 校区地址（个人信息用）

    // 空参构造（MyBatis必须）
    public User() {}

    // 原全参构造（保留，不影响旧功能）
    public User(Integer user_id, String username, String password, String role) {
        this.user_id = user_id;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    // 新增：包含手机号/地址的全参构造（可选，方便测试）
    public User(Integer user_id, String username, String password, String role, String phone, String address) {
        this.user_id = user_id;
        this.username = username;
        this.password = password;
        this.role = role;
        this.phone = phone;
        this.address = address;
    }

    // Getter/Setter（必须，MyBatis赋值用）
    public Integer getUser_id() { return user_id; }
    public void setUser_id(Integer user_id) { this.user_id = user_id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    // ========== 新增字段的Getter/Setter ==========
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
}