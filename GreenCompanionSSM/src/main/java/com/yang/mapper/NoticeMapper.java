package com.yang.mapper;

import com.yang.entity.Notice;
import org.apache.ibatis.annotations.*;
import java.util.List;

public interface NoticeMapper {

    @Select("SELECT * FROM notice WHERE user_id=#{userId} ORDER BY create_time DESC")
    List<Notice> findByUserId(@Param("userId") Integer userId);

    @Delete("DELETE FROM notice WHERE id=#{id} AND user_id=#{userId}")
    int deleteById(@Param("id") Integer id, @Param("userId") Integer userId);

    @Delete("DELETE FROM notice WHERE user_id=#{userId}")
    int deleteByUserId(@Param("userId") Integer userId);

    @Update("UPDATE notice SET read_status=1 WHERE user_id=#{userId}")
    int markAllRead(@Param("userId") Integer userId);

    @Insert("INSERT INTO notice(user_id, content, read_status, create_time) VALUES(#{userId}, #{content}, #{readStatus}, NOW())")
    int insert(Notice notice);

    // ===================== ✅ ✅ ✅ 终极正确 SQL ✅ ✅ ✅ =====================
    @Select("SELECT n.*, u.username FROM notice n LEFT JOIN tb_user u ON n.user_id = u.id ORDER BY n.create_time DESC")
    List<Notice> findAllNotice();

    @Delete("DELETE FROM notice WHERE id = #{id}")
    int deleteNoticeById(Integer id);
}