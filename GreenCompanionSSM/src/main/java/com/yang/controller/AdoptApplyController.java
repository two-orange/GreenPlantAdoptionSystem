package com.yang.controller;

import com.yang.entity.AdoptApply;
import com.yang.entity.Plant;
import com.yang.entity.User;
import com.yang.service.AdoptApplyService;
import com.yang.service.PlantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat; // 新增：导入时间格式化类
import java.util.Date;
import java.util.List;

/**
 * 领养申请核心控制器
 * 解决404 + 注入报错 + 绿植查询报错
 */
@Controller
@RequestMapping("/adopt")
public class AdoptApplyController {

    // 注入Service（必须，解决红波浪线）
    @Autowired
    private PlantService plantService;
    @Autowired
    private AdoptApplyService adoptApplyService;

    // 1. 选择绿植后进入申请页（适配你的adopt_apply.jsp）
    @RequestMapping("/toApply")
    public String toApplyPage(@RequestParam("plantId") Integer plantId, Model model) {
        // 查询选中的绿植信息（解决getPlantById报错）
        Plant plant = plantService.getPlantById(plantId);
        model.addAttribute("plant", plant); // 传递绿植信息到申请页
        return "adopt_apply";
    }

    // 2. 提交领养申请（完善数据库保存）
    @RequestMapping("/submit")
    public String submitApply(AdoptApply apply, HttpSession session) {

        // ========== 原有非空校验+调试打印 ==========
        User user = (User) session.getAttribute("loginUser");
        System.out.println("session中的loginUser：" + user);
        if (user != null) {
            System.out.println("用户ID：" + user.getUser_id());
        }
        // 1. 未登录 → 跳登录页；2. 用户ID为空 → 也跳登录页
        if (user == null || user.getUser_id() == null) {
            return "redirect:/user/toLogin";
        }
        // ==========================================

        // ========== 核心修改：格式化时间为数据库兼容格式 ==========
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String applyTime = sdf.format(new Date()); // 生成 2026-03-11 15:06:24 格式
        // =======================================================

        // 补全申请信息（此时user_id必不为空）
        apply.setUser_id(user.getUser_id());
        apply.setApply_time(applyTime); // 替换原有的 new Date().toString()
        apply.setStatus("待审核");
        // 保存到数据库
        adoptApplyService.saveApply(apply);
        // 提交后跳回用户首页
        return "redirect:/user/toUserIndex";
    }

    // 3. 普通用户查看自己的申请
    @RequestMapping("/toMyApplies")
    public String toMyApplies(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        List<AdoptApply> myApplies = adoptApplyService.getAppliesByUserId(user.getUser_id());
        model.addAttribute("myApplies", myApplies);
        return "adopt_my_list";
    }

    // 4. 管理员查看所有申请（解决404核心方法）
    @RequestMapping("/toAdminList")
    public String toAdminList(Model model) {
        List<AdoptApply> applyList = adoptApplyService.getAllApplies();
        model.addAttribute("applyList", applyList);
        return "adopt_admin_list";
    }

    // 5. 管理员审核申请（通过/拒绝）
    @RequestMapping("/audit")
    public String auditApply(
            @RequestParam("applyId") Integer applyId,
            @RequestParam("status") String status
    ) {
        adoptApplyService.updateStatus(applyId, status);
        return "redirect:/adopt/toAdminList";
    }
}