package com.yang.service;

import com.yang.entity.User;
import com.yang.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserManageService {
    @Autowired
    private UserMapper userMapper;

    // 查询所有用户
    public List<User> getAllUsers() {
        return userMapper.selectAllUsers();
    }

    // 更新用户角色
    public boolean updateUserRole(Integer user_id, String role) {
        int rows = userMapper.updateUserRole(user_id, role);
        return rows > 0;
    }
}