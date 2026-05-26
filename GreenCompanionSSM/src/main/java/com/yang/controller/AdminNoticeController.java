package com.yang.controller;

import com.yang.entity.Notice;
import com.yang.entity.User;
import com.yang.service.NoticeService;
import com.yang.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin/notice")
public class AdminNoticeController {

    @Autowired
    private UserService userService;
    @Autowired
    private NoticeService noticeService;

    // 进入用户管理页面（已融合通知功能）
    @RequestMapping("/toNoticeAdmin")
    public String toNoticeAdmin(Model model, HttpSession session) {
        // 校验管理员身份（中文角色：管理员）
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"管理员".equals(loginUser.getRole())) {
            return "redirect:/user/toLogin";
        }

        // 加载用户列表 + 通知列表
        model.addAttribute("userList", userService.findAllUser());
        model.addAttribute("noticeList", noticeService.findAllNotice());

        // 跳转到用户管理页面
        return "user_manage_list";
    }

    // 批量发送通知给选中用户
    @RequestMapping("/send")
    @ResponseBody
    public Map<String, Object> send(String userIds, String content) {
        Map<String, Object> result = new HashMap<>();
        try {
            noticeService.sendToUsers(userIds, content);
            result.put("code", 200);
            result.put("msg", "通知发送成功！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "发送失败：" + e.getMessage());
        }
        return result;
    }

    // 撤回通知
    @RequestMapping("/rollback")
    @ResponseBody
    public Map<String, Object> rollback(Integer id) {
        Map<String, Object> result = new HashMap<>();
        try {
            noticeService.deleteById(id);
            result.put("code", 200);
            result.put("msg", "通知撤回成功！");
        } catch (Exception e) {
            result.put("code", 500);
            result.put("msg", "撤回失败：" + e.getMessage());
        }
        return result;
    }
}