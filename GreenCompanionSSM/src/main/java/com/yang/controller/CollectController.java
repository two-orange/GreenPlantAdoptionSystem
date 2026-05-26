package com.yang.controller;

import com.yang.entity.Plant;
import com.yang.entity.User;
import com.yang.service.CollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/collect")
public class CollectController {

    @Autowired
    private CollectService collectService;

    @RequestMapping("/toggle")
    @ResponseBody
    public Map<String, Object> toggle(Integer plantId, HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        Map<String, Object> map = new HashMap<>();
        if (user == null) {
            map.put("status", -1);
            map.put("msg", "请先登录");
            return map;
        }

        int exist = collectService.isCollectExist(user.getUser_id(), plantId);
        if (exist > 0) {
            collectService.deleteCollect(user.getUser_id(), plantId);
            map.put("status", 0);
            map.put("msg", "取消收藏成功");
        } else {
            collectService.addCollect(user.getUser_id(), plantId);
            map.put("status", 1);
            map.put("msg", "收藏成功");
        }
        return map;
    }

    @RequestMapping("/myList")
    public String myCollect(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/user/login";
        }
        List<Plant> list = collectService.getMyCollect(user.getUser_id());
        model.addAttribute("plantList", list);
        return "myCollect"; // 🔥 用你原来的页面，不404
    }
    // 新增：判断是否已收藏（给前端JS调用）
    @RequestMapping("/isCollect")
    @ResponseBody
    public boolean isCollect(Integer userId, Integer plantId) {
        return collectService.isCollectExist(userId, plantId) > 0;
    }
}