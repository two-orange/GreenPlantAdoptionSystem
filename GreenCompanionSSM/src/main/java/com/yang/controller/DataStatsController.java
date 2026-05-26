package com.yang.controller;

import com.yang.service.DataStatsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/stats")
public class DataStatsController {

    @Autowired
    private DataStatsService dataStatsService;

    // 进入数据统计中心
    @RequestMapping("/dataCenter")
    public String dataCenter(Model model, HttpSession session) {
        // 权限校验（仅管理员）
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/user/toLogin";
        }

        // 1. 用户活跃度统计
        model.addAttribute("activeUserList", dataStatsService.getUserActiveStats());

        // 2. 绿植领养/交换 趋势数据
        model.addAttribute("plantTrendData", dataStatsService.getPlantTrendStats());

        // 3. 全局统计数字
        model.addAttribute("totalStats", dataStatsService.getTotalBaseStats());

        return "data_stats_center";
    }
}