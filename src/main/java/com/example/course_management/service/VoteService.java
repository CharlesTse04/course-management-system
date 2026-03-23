package com.example.course_management.service;

import com.example.course_management.model.Vote;
import com.example.course_management.model.PollOption;
import com.example.course_management.model.Poll;
import com.example.course_management.model.User;
import com.example.course_management.repository.VoteRepository;
import com.example.course_management.repository.PollOptionRepository;
import com.example.course_management.repository.PollRepository;
import com.example.course_management.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class VoteService {
    
    @Autowired
    private VoteRepository voteRepository;
    
    @Autowired
    private PollOptionRepository pollOptionRepository;
    
    @Autowired
    private PollRepository pollRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    public Vote saveVote(Long userId, Long pollId, Long optionId) {
        Optional<User> userOpt = userRepository.findById(userId);
        Optional<Poll> pollOpt = pollRepository.findById(pollId);
        Optional<PollOption> optionOpt = pollOptionRepository.findById(optionId);
        
        if (userOpt.isPresent() && pollOpt.isPresent() && optionOpt.isPresent()) {
            Optional<Vote> existingVote = voteRepository.findByUserIdAndPollId(userId, pollId);
            
            if (existingVote.isPresent()) {
                Vote vote = existingVote.get();
                vote.setPollOption(optionOpt.get());
                vote.setUpdatedAt(LocalDateTime.now());
                return voteRepository.save(vote);
            } else {
                Vote vote = new Vote(userOpt.get(), pollOpt.get(), optionOpt.get());
                return voteRepository.save(vote);
            }
        }
        return null;
    }
    
    public Vote getUserVoteByPollId(Long userId, Long pollId) {
        return voteRepository.findByUserIdAndPollId(userId, pollId).orElse(null);
    }
    
    public List<Vote> getVotesByUserId(Long userId) {
        return voteRepository.findByUserId(userId);
    }
    
}
