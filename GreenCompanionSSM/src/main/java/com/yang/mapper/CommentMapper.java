package com.yang.mapper;

import com.yang.entity.Comment;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import java.util.List;

public interface CommentMapper {

    @Insert("INSERT INTO plant_comment(plant_id, user_id, content, username) VALUES(#{plantId}, #{userId}, #{content}, #{username})")
    int addComment(Comment c);

    @Select("SELECT * FROM plant_comment WHERE plant_id=#{plantId} ORDER BY create_time DESC")
    List<Comment> getCommentsByPlantId(@Param("plantId") Integer plantId);

    @Delete("DELETE FROM plant_comment WHERE id=#{id} AND user_id=#{userId}")
    int deleteComment(@Param("id") Integer id, @Param("userId") Integer userId);
}