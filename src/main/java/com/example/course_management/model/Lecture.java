package com.example.course_management.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "lectures")
public class Lecture {
    
    @Transient
    private String formattedCreatedAt;
    


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false, length = 200)
    private String title;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Column(name = "detailed_summary", columnDefinition = "TEXT")
    private String detailedSummary;
    
    @Column(name = "instructor_name", length = 100)
    private String instructorName;
    
    @Column(name = "instructor_bio", columnDefinition = "TEXT")
    private String instructorBio;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @ManyToOne
    @JoinColumn(name = "created_by")
    private User createdBy;
    
    @OneToMany(mappedBy = "lecture", cascade = CascadeType.ALL)
    private List<Material> materials;
    
    @OneToMany(mappedBy = "lecture", cascade = CascadeType.ALL)
    private List<Comment> comments;
    
    // ========== 以下為 transient 屬性，不存儲在數據庫 ==========
    @Transient
    private int materialCount;
    
    @Transient
    private int commentCount;
    // =======================================================
    
    public Lecture() {}
    
    public Lecture(String title, String description) {
        this.title = title;
        this.description = description;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    // 計算 materialCount（在獲取時自動計算）
    public int getMaterialCount() {
        if (materials != null) {
            return materials.size();
        }
        return 0;
    }
    
    public void setMaterialCount(int materialCount) {
        this.materialCount = materialCount;
    }
    
    // 計算 commentCount
    public int getCommentCount() {
        if (comments != null) {
            return comments.size();
        }
        return 0;
    }
    
    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getDetailedSummary() { return detailedSummary; }
    public void setDetailedSummary(String detailedSummary) { this.detailedSummary = detailedSummary; }
    
    public String getInstructorName() { return instructorName; }
    public void setInstructorName(String instructorName) { this.instructorName = instructorName; }
    
    public String getInstructorBio() { return instructorBio; }
    public void setInstructorBio(String instructorBio) { this.instructorBio = instructorBio; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public User getCreatedBy() { return createdBy; }
    public void setCreatedBy(User createdBy) { this.createdBy = createdBy; }
    
    public List<Material> getMaterials() { return materials; }
    public void setMaterials(List<Material> materials) { 
        this.materials = materials;
        this.materialCount = materials != null ? materials.size() : 0;
    }
    
    public List<Comment> getComments() { return comments; }
    public void setComments(List<Comment> comments) { 
        this.comments = comments;
        this.commentCount = comments != null ? comments.size() : 0;
    }
    
    public String getFormattedCreatedAt() {
        return formattedCreatedAt;
    }
    
    public void setFormattedCreatedAt(String formattedCreatedAt) {
        this.formattedCreatedAt = formattedCreatedAt;
    }
}
        
