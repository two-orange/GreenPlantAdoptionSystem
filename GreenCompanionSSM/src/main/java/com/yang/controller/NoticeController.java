package com.yang.controller;

import com.yang.entity.Notice;
import com.yang.entity.User;
import com.yang.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeService service;

    // 列表
    @RequestMapping("/list")
    @ResponseBody
    public List<Notice> list(HttpSession session) {
        User u = (User) session.getAttribute("loginUser");
        return service.list(u.getUser_id());
    }

    // 删除单条
    @RequestMapping("/delete")
    @ResponseBody
    public String delete(Integer id, HttpSession session) {
        User u = (User) session.getAttribute("loginUser");
        service.delete(id, u.getUser_id());
        return "ok";
    }

    // 清空全部
    @RequestMapping("/clearAll")
    @ResponseBody
    public String clearAll(HttpSession session) {
        User u = (User) session.getAttribute("loginUser");
        service.clear(u.getUser_id());
        return "ok";
    }

    // 全部已读-*--
    @RequestMapping("/markAllRead")
    @ResponseBody
    public String markAllRead(HttpSession session) {
        User u = (User) session.getAttribute("loginUser");
        service.markAllRead(u.getUser_id());
        return "ok";
    }
}