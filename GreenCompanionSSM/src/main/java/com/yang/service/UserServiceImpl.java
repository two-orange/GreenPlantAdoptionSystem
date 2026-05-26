package com.yang.service;

import com.yang.entity.User;
import com.yang.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;  // 必须加这个

// 用户业务层实现类：处理登录+个人信息逻辑
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    // 1. 原有登录逻辑（完全保留，不改动）
    @Override
    public User login(String username, String password) {
        User user = userMapper.getUserByUsername(username);
        // 密码匹配（毕设简化版，实际可加加密）
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    // 2. 新增：根据用户ID查询个人信息
    @Override
    public User getUserInfo(Integer user_id) {
        // 给参数加@Param注解匹配Mapper的参数名（否则极端情况可能参数绑定失败）
        return userMapper.selectById(user_id);
    }

    // 3. 新增：修改个人信息（手机号+地址）
    @Override
    public boolean updateUserInfo(User user) {
        // 调用Mapper更新，返回受影响行数>0则修改成功
        int rows = userMapper.updateInfo(user);
        return rows > 0;
    }

    // ===================== 管理员发通知：查询所有用户 =====================
    @Override
    public List<User> findAllUser() {
        return userMapper.findAllUser();
    }
}