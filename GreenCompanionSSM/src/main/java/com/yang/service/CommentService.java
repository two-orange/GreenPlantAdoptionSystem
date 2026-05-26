package com.yang.service;

import com.yang.entity.Comment;
import com.yang.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentMapper commentMapper;

    // 发表留言
    public int addComment(Comment c) {
        return commentMapper.addComment(c);
    }

    // 查询某绿植的所有留言（按时间倒序）
    public List<Comment> getCommentsByPlantId(Integer plantId) {
        return commentMapper.getCommentsByPlantId(plantId);
    }

    // 删除自己的留言
    public int deleteComment(Integer id, Integer userId) {
        return commentMapper.deleteComment(id, userId);
    }
}