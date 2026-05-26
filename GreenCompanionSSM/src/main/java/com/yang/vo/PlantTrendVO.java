package com.yang.vo;

public class PlantTrendVO {
    private String dateStr;
    private Integer pendingCount;  // 待审核
    private Integer adoptCount;    // 已通过（领养）
    private Integer rejectCount;  // 已拒绝

    // getter/setter
    public String getDateStr() { return dateStr; }
    public void setDateStr(String dateStr) { this.dateStr = dateStr; }
    public Integer getPendingCount() { return pendingCount; }
    public void setPendingCount(Integer pendingCount) { this.pendingCount = pendingCount; }
    public Integer getAdoptCount() { return adoptCount; }
    public void setAdoptCount(Integer adoptCount) { this.adoptCount = adoptCount; }
    public Integer getRejectCount() { return rejectCount; }
    public void setRejectCount(Integer rejectCount) { this.rejectCount = rejectCount; }
}