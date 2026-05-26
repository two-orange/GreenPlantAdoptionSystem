package com.yang.controller;

import com.yang.entity.Knowledge;
import com.yang.entity.User; // 新增：导入User类做权限校验
import com.yang.service.KnowledgeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody; // 新增：返回JSON

import javax.servlet.http.HttpSession; // 新增：获取登录信息
import java.util.HashMap; // 新增：返回JSON数据
import java.util.List;
import java.util.Map; // 新增：返回JSON数据

@Controller
@RequestMapping("/knowledge")
public class KnowledgeController {
    @Autowired
    private KnowledgeService knowledgeService;

    // 原有：查看所有养护知识（保留不动）
    @RequestMapping("/toList")
    public String toKnowledgeList(Model model) {
        List<Knowledge> knowledgeList = knowledgeService.getAllKnowledge();
        model.addAttribute("knowledgeList", knowledgeList);
        return "knowledge_list";
    }

    // 原有：查看知识详情（保留不动）
    @RequestMapping("/toDetail")
    public String toKnowledgeDetail(@RequestParam("id") Integer knowledge_id, Model model) {
        Knowledge knowledge = knowledgeService.getKnowledgeById(knowledge_id);
        model.addAttribute("knowledge", knowledge);
        return "knowledge_detail";
    }

    // ========== 新增：更新养护知识相关接口 ==========
    // 1. 跳转到编辑页面（仅管理员可访问）
    @RequestMapping("/toEdit")
    public String toKnowledgeEdit(@RequestParam("id") Integer knowledge_id, Model model, HttpSession session) {
        // 权限校验：只有管理员能进入编辑页
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"管理员".equals(loginUser.getRole())) {
            return "redirect:/knowledge/toList"; // 非管理员跳回列表页
        }
        Knowledge knowledge = knowledgeService.getKnowledgeById(knowledge_id);
        model.addAttribute("knowledge", knowledge);
        return "knowledge_edit"; // 对应WEB-INF/views/knowledge_edit.jsp
    }

    // 2. 保存更新（AJAX接口，返回JSON）
    @RequestMapping("/update")
    @ResponseBody // 关键：返回JSON，不是跳转页面
    public Map<String, Object> updateKnowledge(
            @RequestParam("id") Integer knowledge_id, // 对应前端传的id
            @RequestParam String title,
            @RequestParam String content,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        // 1. 权限校验
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"管理员".equals(loginUser.getRole())) {
            result.put("code", 500);
            result.put("msg", "只有管理员能更新养护知识！");
            return result;
        }

        // 2. 封装更新数据
        Knowledge knowledge = new Knowledge();
        knowledge.setKnowledge_id(knowledge_id);
        knowledge.setTitle(title);
        knowledge.setContent(content);

        // 3. 调用Service更新
        boolean flag = knowledgeService.updateKnowledge(knowledge);
        if (flag) {
            result.put("code", 200);
            result.put("msg", "更新成功！");
        } else {
            result.put("code", 500);
            result.put("msg", "更新失败！");
        }
        return result;
    }
}