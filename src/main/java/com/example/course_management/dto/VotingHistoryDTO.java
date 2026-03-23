package com.example.course_management.dto;

import java.time.LocalDateTime;

public class VotingHistoryDTO {
    private Long pollId;
    private String pollQuestion;
    private String selectedOption;
    private LocalDateTime votedAt;
    private String formattedVotedAt;
    private boolean isCurrent;
    
    public Long getPollId() { return pollId; }
    public void setPollId(Long pollId) { this.pollId = pollId; }
    
    public String getPollQuestion() { return pollQuestion; }
    public void setPollQuestion(String pollQuestion) { this.pollQuestion = pollQuestion; }
    
    public String getSelectedOption() { return selectedOption; }
    public void setSelectedOption(String selectedOption) { this.selectedOption = selectedOption; }
    
    public LocalDateTime getVotedAt() { return votedAt; }
    public void setVotedAt(LocalDateTime votedAt) { this.votedAt = votedAt; }
    
    public String getFormattedVotedAt() { return formattedVotedAt; }
    public void setFormattedVotedAt(String formattedVotedAt) { this.formattedVotedAt = formattedVotedAt; }
    
    public boolean isCurrent() { return isCurrent; }
    public void setCurrent(boolean current) { isCurrent = current; }
}
