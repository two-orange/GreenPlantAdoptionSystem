package com.yang.entity;

public class Knowledge {
    private Integer knowledge_id;
    private String title;
    private String content;
    private String create_time;

    public Knowledge() {}

    public Knowledge(Integer knowledge_id, String title, String content, String create_time) {
        this.knowledge_id = knowledge_id;
        this.title = title;
        this.content = content;
        this.create_time = create_time;
    }

    // Getter/Setter
    public Integer getKnowledge_id() { return knowledge_id; }
    public void setKnowledge_id(Integer knowledge_id) { this.knowledge_id = knowledge_id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getCreate_time() { return create_time; }
    public void setCreate_time(String create_time) { this.create_time = create_time; }
}