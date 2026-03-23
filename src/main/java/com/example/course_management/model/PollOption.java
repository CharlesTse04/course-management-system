package com.example.course_management.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "poll_options")
public class PollOption {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "poll_id", nullable = false)
    private Poll poll;
    
    @Column(name = "option_text", nullable = false, length = 255)
    private String optionText;
    
    @Column(name = "display_order", nullable = false)
    private Integer displayOrder;
    
    @OneToMany(mappedBy = "pollOption")
    private List<Vote> votes;
    
    @Transient
    private int voteCount;
    
    public PollOption() {}
    
    public PollOption(Poll poll, String optionText, Integer displayOrder) {
        this.poll = poll;
        this.optionText = optionText;
        this.displayOrder = displayOrder;
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Poll getPoll() { return poll; }
    public void setPoll(Poll poll) { this.poll = poll; }
    
    public String getOptionText() { return optionText; }
    public void setOptionText(String optionText) { this.optionText = optionText; }
    
    public Integer getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(Integer displayOrder) { this.displayOrder = displayOrder; }
    
    public List<Vote> getVotes() { return votes; }
    public void setVotes(List<Vote> votes) { 
        this.votes = votes;
        if (votes != null) {
            this.voteCount = votes.size();
        }
    }
    
    public int getVoteCount() {
        if (votes != null && !votes.isEmpty()) {
            return votes.size();
        }
        return voteCount;
    }
    
    public void setVoteCount(int voteCount) {
        this.voteCount = voteCount;
    }
}
