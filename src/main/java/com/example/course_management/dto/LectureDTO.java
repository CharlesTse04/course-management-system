package com.example.course_management.dto;

import java.time.LocalDateTime;
import java.util.List;

public class LectureDTO {
    private Long id;
    private String title;
    private String description;
    private String instructorName;
    private int materialCount;
    private int commentCount;
    private List<CommentDTO> comments;
    private LocalDateTime createdAt;
    
    public LectureDTO() {}
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getInstructorName() { return instructorName; }
    public void setInstructorName(String instructorName) { this.instructorName = instructorName; }
    
    public int getMaterialCount() { return materialCount; }
    public void setMaterialCount(int materialCount) { this.materialCount = materialCount; }
    
    public int getCommentCount() { return commentCount; }
    public void setCommentCount(int commentCount) { this.commentCount = commentCount; }
    
    public List<CommentDTO> getComments() { return comments; }
    public void setComments(List<CommentDTO> comments) { this.comments = comments; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
