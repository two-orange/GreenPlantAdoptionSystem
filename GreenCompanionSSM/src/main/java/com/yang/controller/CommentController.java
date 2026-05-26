package com.yang.controller;

import com.yang.entity.Comment;
import com.yang.entity.User;
import com.yang.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    // 发表留言
    @RequestMapping("/add")
    @ResponseBody
    public Map<String, Object> add(Comment comment, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            map.put("msg", "请先登录");
            return map;
        }
        comment.setUserId(user.getUser_id());
        comment.setUsername(user.getUsername());
        commentService.addComment(comment);
        map.put("msg", "发表成功");
        return map;
    }

    // 加载留言列表（给页面AJAX用）
    @RequestMapping("/list")
    @ResponseBody
    public List<Comment> list(Integer plantId) {
        return commentService.getCommentsByPlantId(plantId);
    }

    // 删除留言（只能删自己的）
    @RequestMapping("/del")
    @ResponseBody
    public Map<String, Object> delete(Integer id, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            map.put("msg", "请先登录");
            return map;
        }
        commentService.deleteComment(id, user.getUser_id());
        map.put("msg", "删除成功");
        return map;
    }
}