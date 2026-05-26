package com.yang.mapper;

import com.yang.vo.UserActiveVO;
import com.yang.vo.PlantTrendVO;
import org.apache.ibatis.annotations.Select;
import java.util.List;
import java.util.Map;

public interface DataStatsMapper {

    // 1. 用户活跃度统计（已修复，用 tb_user.id 关联 notice.user_id）
    @Select("SELECT " +
            "u.id AS id, u.username, u.phone, " +
            "COUNT(n.id) AS totalNotice, " +
            "SUM(CASE WHEN n.read_status = 1 THEN 1 ELSE 0 END) AS readNotice " +
            "FROM tb_user u " +
            "LEFT JOIN notice n ON u.id = n.user_id " +
            "GROUP BY u.id, u.username, u.phone " +
            "ORDER BY totalNotice DESC")
    List<UserActiveVO> selectUserActiveStats();

    // 2. 绿植领养趋势统计（已修复，用 audit_status 字段）
    @Select("SELECT " +
            "DATE(apply_time) AS dateStr, " +
            "COUNT(CASE WHEN audit_status = '待审核' THEN 1 END) AS pendingCount, " +
            "COUNT(CASE WHEN audit_status = '已通过' THEN 1 END) AS adoptCount, " +
            "COUNT(CASE WHEN audit_status = '已拒绝' THEN 1 END) AS rejectCount " +
            "FROM tb_adopt_apply " +
            "GROUP BY DATE(apply_time) " +
            "ORDER BY dateStr ASC")
    List<PlantTrendVO> selectPlantTrendStats();

    // 3. 全局基础统计
    @Select("SELECT " +
            "(SELECT COUNT(*) FROM tb_user) AS userCount, " +
            "(SELECT COUNT(*) FROM tb_plant_info) AS plantCount, " +
            "(SELECT COUNT(*) FROM tb_adopt_apply) AS applyCount")
    Map<String, Object> selectTotalBaseStats();
}