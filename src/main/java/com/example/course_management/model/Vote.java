package com.example.course_management.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "votes")
public class Vote {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "poll_id")
    private Poll poll;
    
    @ManyToOne
    @JoinColumn(name = "poll_option_id")
    private PollOption pollOption;
    
    @Column(name = "user_id", insertable = false, updatable = false)
    private Long userId;
    
    @Column(name = "poll_id", insertable = false, updatable = false)
    private Long pollId;
    
    @Column(name = "poll_option_id", insertable = false, updatable = false)
    private Long pollOptionId;
    
    @Column(name = "voted_at")
    private LocalDateTime votedAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    public Vote() {}
    
    public Vote(User user, Poll poll, PollOption pollOption) {
        this.user = user;
        this.poll = poll;
        this.pollOption = pollOption;
        this.votedAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    
    public Poll getPoll() { return poll; }
    public void setPoll(Poll poll) { this.poll = poll; }
    
    public PollOption getPollOption() { return pollOption; }
    public void setPollOption(PollOption pollOption) { this.pollOption = pollOption; }
    
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    
    public Long getPollId() { return pollId; }
    public void setPollId(Long pollId) { this.pollId = pollId; }
    
    public Long getPollOptionId() { return pollOptionId; }
    public void setPollOptionId(Long pollOptionId) { this.pollOptionId = pollOptionId; }
    
    public LocalDateTime getVotedAt() { return votedAt; }
    public void setVotedAt(LocalDateTime votedAt) { this.votedAt = votedAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

}
