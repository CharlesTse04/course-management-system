package com.example.course_management.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "polls")
public class Poll {
    
    @Transient
    private String formattedCreatedAt;
    
    public String getFormattedCreatedAt() {
        return formattedCreatedAt;
    }
    
    public void setFormattedCreatedAt(String formattedCreatedAt) {
        this.formattedCreatedAt = formattedCreatedAt;
    }

    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false, length = 500)
    private String question;
    
    private Boolean active = true;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @ManyToOne
    @JoinColumn(name = "created_by")
    private User createdBy;
    
    @OneToMany(mappedBy = "poll", cascade = CascadeType.ALL)
    private List<PollOption> options;
    
    @OneToMany(mappedBy = "poll", cascade = CascadeType.ALL)
    private List<Comment> comments;
    
    @OneToMany(mappedBy = "poll")
    private List<Vote> votes;
    
    // ========== transient 屬性 ==========
    @Transient
    private int totalVotes;
    
    @Transient
    private int commentCount;
    
    @Transient
    private String userVoted;
    // ===================================
    
    public Poll() {}
    
    public Poll(String question) {
        this.question = question;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    public int getTotalVotes() {
        if (votes != null) {
            return votes.size();
        }
        return 0;
    }
    
    public void setTotalVotes(int totalVotes) {
        this.totalVotes = totalVotes;
    }
    
    public int getCommentCount() {
        if (comments != null) {
            return comments.size();
        }
        return 0;
    }
    
    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }
    
    public String getUserVoted() {
        return userVoted;
    }
    
    public void setUserVoted(String userVoted) {
        this.userVoted = userVoted;
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }
    
    public Boolean getActive() { return active; }
    public void setActive(Boolean active) { this.active = active; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public User getCreatedBy() { return createdBy; }
    public void setCreatedBy(User createdBy) { this.createdBy = createdBy; }
    
    public List<PollOption> getOptions() { return options; }
    public void setOptions(List<PollOption> options) { this.options = options; }
    
    public List<Comment> getComments() { return comments; }
    public void setComments(List<Comment> comments) { 
        this.comments = comments;
        this.commentCount = comments != null ? comments.size() : 0;
    }
    
    public List<Vote> getVotes() { return votes; }
    public void setVotes(List<Vote> votes) { 
        this.votes = votes;
        this.totalVotes = votes != null ? votes.size() : 0;
    }
}
    