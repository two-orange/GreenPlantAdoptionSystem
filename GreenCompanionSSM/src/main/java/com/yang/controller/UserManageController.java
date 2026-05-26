package com.yang.controller;

import com.yang.entity.User;
import com.yang.service.NoticeService;
import com.yang.service.UserManageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/userManage")
public class UserManageController {
    @Autowired
    private UserManageService userManageService;

    // 注入通知服务
    @Autowired
    private NoticeService noticeService;

    @RequestMapping("/toList")
    public String toUserList(Model model, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"管理员".equals(loginUser.getRole())) {
            return "redirect:/user/toUserIndex";
        }

        List<User> userList = userManageService.getAllUsers();
        model.addAttribute("userList", userList);

        // 加载通知记录 → 现在正常不报错了！
        model.addAttribute("noticeList", noticeService.findAllNotice());

        return "user_manage_list";
    }

    @RequestMapping("/updateRole")
    @ResponseBody
    public Map<String, Object> updateUserRole(
            @RequestParam Integer user_id,
            @RequestParam String role,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"管理员".equals(loginUser.getRole())) {
            result.put("code", 500);
            result.put("msg", "只有管理员能修改！");
            return result;
        }
        boolean flag = userManageService.updateUserRole(user_id, role);
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