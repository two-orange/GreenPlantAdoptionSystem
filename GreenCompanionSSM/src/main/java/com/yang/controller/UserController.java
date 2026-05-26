package com.yang.controller;

import com.yang.entity.User;
import com.yang.service.UserService; // 👉 加上这一行！
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

// 用户控制层：处理登录/注销 + 个人信息管理
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    // 1. 跳转到登录页面（原有，保留）
    @RequestMapping("/toLogin")
    public String toLoginPage() {
        return "login"; // 对应WEB-INF/views/login.jsp
    }

    // 2. 处理登录请求（原有，保留）
    @RequestMapping("/login")
    public String login(String username, String password, Model model, HttpSession session) {
        User user = userService.login(username, password);
        if (user != null) {
            // 登录成功：保存用户到Session，区分角色
            session.setAttribute("loginUser", user);
            // 新增：把用户ID单独存到Session（方便后续个人信息接口使用）
            session.setAttribute("user_id", user.getUser_id());
            // 管理员跳后台，普通用户跳首页
            if ("管理员".equals(user.getRole())) {
                return "redirect:/plant/toList"; // 管理员跳绿植管理列表
            } else {
                return "redirect:/user/toUserIndex"; // 普通用户跳专属首页
            }
        } else {
            // 登录失败：提示错误，返回登录页
            model.addAttribute("loginError", "用户名或密码错误！");
            return "login";
        }
    }

    // 3. 注销登录（原有，保留）
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 清空Session
        return "redirect:/user/toLogin"; // 跳回登录页
    }

    // 4. 跳转到普通用户首页（原有，保留）
    @RequestMapping("/toUserIndex")
    public String toUserIndex() {
        return "user_index"; // 对应WEB-INF/views/user_index.jsp
    }

    // ========== 新增：个人信息管理接口 ==========
    // 5. 跳转到个人信息修改页面（可选，也可以直接在user_index.jsp里做）
    @RequestMapping("/toUserInfo")
    public String toUserInfo() {
        return "user_info"; // 对应WEB-INF/views/user_info.jsp（如果单独做信息页）
    }

    // 6. 核心：查询当前登录用户的个人信息（返回JSON）
    @RequestMapping("/getUserInfo")
    @ResponseBody // 关键：返回JSON数据，不是跳转页面
    public Map<String, Object> getUserInfo(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        // 从Session获取当前用户ID（登录时已存入）
        Integer user_id = (Integer) session.getAttribute("user_id");

        // 未登录校验
        if (user_id == null) {
            result.put("code", 500);
            result.put("msg", "请先登录！");
            return result;
        }

        // 查询个人信息
        User user = userService.getUserInfo(user_id);
        if (user != null) {
            result.put("code", 200);
            result.put("msg", "查询成功");
            result.put("data", user); // 返回用户信息（含手机号、地址）
        } else {
            result.put("code", 500);
            result.put("msg", "查询失败");
        }
        return result;
    }

    // 7. 核心：修改个人信息（手机号+地址）
    @RequestMapping("/updateUserInfo")
    @ResponseBody // 关键：返回JSON数据
    public Map<String, Object> updateUserInfo(
            @RequestParam String phone, // 前端传的手机号
            @RequestParam String address, // 前端传的校区地址
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        Integer user_id = (Integer) session.getAttribute("user_id");

        // 未登录校验
        if (user_id == null) {
            result.put("code", 500);
            result.put("msg", "请先登录！");
            return result;
        }

        // 封装用户数据（只改手机号和地址）
        User user = new User();
        user.setUser_id(user_id); // 绑定当前用户ID，防止改别人的信息
        user.setPhone(phone);
        user.setAddress(address);

        // 调用业务层修改
        boolean flag = userService.updateUserInfo(user);
        if (flag) {
            result.put("code", 200);
            result.put("msg", "修改成功！");
        } else {
            result.put("code", 500);
            result.put("msg", "修改失败！");
        }
        return result;
    }
}