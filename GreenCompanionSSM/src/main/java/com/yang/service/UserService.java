package com.yang.service;
import com.yang.entity.User;
import java.util.List;  // 必须加这个

// 用户业务层接口
public interface UserService {
    // 登录校验
    User login(String username, String password);

    // 查询个人信息
    User getUserInfo(Integer user_id);

    // 修改个人信息
    boolean updateUserInfo(User user);

    // 查询所有用户（管理员发通知用）
    List<User> findAllUser();
}