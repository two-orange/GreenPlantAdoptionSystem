package com.yang.service;
import com.yang.entity.Notice;
import com.yang.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class NoticeService {
    @Autowired
    NoticeMapper mapper;

    public List<Notice> list(Integer userId){
        return mapper.findByUserId(userId);
    }
    public int delete(Integer id, Integer userId){
        return mapper.deleteById(id, userId);
    }
    public int clear(Integer userId){
        return mapper.deleteByUserId(userId);
    }
    public int markAllRead(Integer userId){
        return mapper.markAllRead(userId);
    }

    // ====================== 管理员功能新加 ======================
    // 查询所有通知（管理员用）
    public List<Notice> findAllNotice() {
        return mapper.findAllNotice();
    }

    // 批量发送通知给多个用户
    public void sendToUsers(String userIds, String content) {
        String[] ids = userIds.split(",");
        for (String id : ids) {
            Notice notice = new Notice();
            notice.setUserId(Integer.parseInt(id));
            notice.setContent(content);
            notice.setReadStatus(0);
            mapper.insert(notice);
        }
    }

    // 管理员撤回通知（按ID删除）
    public int deleteById(Integer id) {
        return mapper.deleteNoticeById(id);
    }
}