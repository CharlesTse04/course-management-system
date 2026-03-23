package com.example.course_management.dto;

import java.time.LocalDateTime;

public class CommentHistoryDTO {
    private Long id;
    private String content;
    private LocalDateTime createdAt;
    private String formattedDate;      // 完整日期時間字符串
    private String formattedDateOnly;  // 僅日期字符串
    private String timeAgo;
    private String sourceType;
    private String sourceTitle;
    private String sourceUrl;
    
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public String getFormattedDate() { return formattedDate; }
    public void setFormattedDate(String formattedDate) { this.formattedDate = formattedDate; }
    
    public String getFormattedDateOnly() { return formattedDateOnly; }
    public void setFormattedDateOnly(String formattedDateOnly) { this.formattedDateOnly = formattedDateOnly; }
    
    public String getTimeAgo() { return timeAgo; }
    public void setTimeAgo(String timeAgo) { this.timeAgo = timeAgo; }
    
    public String getSourceType() { return sourceType; }
    public void setSourceType(String sourceType) { this.sourceType = sourceType; }
    
    public String getSourceTitle() { return sourceTitle; }
    public void setSourceTitle(String sourceTitle) { this.sourceTitle = sourceTitle; }
    
    public String getSourceUrl() { return sourceUrl; }
    public void setSourceUrl(String sourceUrl) { this.sourceUrl = sourceUrl; }
}
