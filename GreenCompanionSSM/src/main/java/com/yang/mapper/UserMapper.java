package com.yang.mapper;

import com.yang.entity.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List; // 新增：导入List集合

public interface UserMapper {
    // 1. 原有登录校验：修正字段映射（campus_address → address 匹配实体类）
    @Select("SELECT id AS user_id, username, password, role, phone, campus_address AS address " +
            "FROM tb_user WHERE username = #{username}")
    User getUserByUsername(String username);

    // 2. 新增：根据ID查询用户信息（适配实体类user_id + 表tb_user）
    @Select("SELECT id AS user_id, username, password, role, phone, campus_address AS address " +
            "FROM tb_user WHERE id = #{user_id}")
    User selectById(@Param("user_id") Integer user_id);

    // 3. 新增：更新用户信息（只改手机号+地址，适配tb_user表）
    @Update("UPDATE tb_user SET phone = #{phone}, campus_address = #{address} WHERE id = #{user_id}")
    int updateInfo(User user);

    // ========== 新增：管理员用户管理相关方法 ==========
    // 4. 查询所有用户（管理员查看全部用户）
    @Select("SELECT id AS user_id, username, password, role, phone, campus_address AS address FROM tb_user")
    List<User> selectAllUsers();

    // 5. 更新用户角色（管理员切换用户角色：user/管理员）
    @Update("UPDATE tb_user SET role = #{role} WHERE id = #{user_id}")
    int updateUserRole(@Param("user_id") Integer user_id, @Param("role") String role);

    // 查询所有用户（管理员发送通知使用）
    @Select("SELECT * FROM user")
    List<User> findAllUser();
}