package com.example.course_management.dto;

import java.time.LocalDateTime;

public class CommentDTO {
    private Long id;
    private String username;
    private String userFullName;
    private String content;
    private LocalDateTime createdAt;
    
    public CommentDTO() {}
    
    public CommentDTO(Long id, String username, String userFullName, String content, LocalDateTime createdAt) {
        this.id = id;
        this.username = username;
        this.userFullName = userFullName;
        this.content = content;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getUserFullName() { return userFullName; }
    public void setUserFullName(String userFullName) { this.userFullName = userFullName; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
