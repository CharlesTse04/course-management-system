package com.example.course_management.service;

import com.example.course_management.model.Poll;
import com.example.course_management.model.PollOption;
import com.example.course_management.repository.PollRepository;
import com.example.course_management.repository.PollOptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PollService {
    
    @Autowired
    private PollRepository pollRepository;
    
    @Autowired
    private PollOptionRepository pollOptionRepository;
    
    public List<Poll> getAllPolls() {
        return pollRepository.findAll();
    }
    
    public PollOption getOptionById(Long optionId) {
        Optional<PollOption> option = pollOptionRepository.findById(optionId);
        return option.orElse(null);
    }

    public List<Poll> getActivePolls() {
        return pollRepository.findByActiveTrue();
    }
    
    public Poll getPollById(Long id) {
        Optional<Poll> poll = pollRepository.findById(id);
        return poll.orElse(null);
    }
    
    public List<PollOption> getOptionsByPollId(Long pollId) {
        return pollOptionRepository.findByPollId(pollId);
    }
    
    public Poll createPoll(Poll poll) {
        return pollRepository.save(poll);
    }
    
    public PollOption addOption(Long pollId, String optionText, int displayOrder) {
        Poll poll = getPollById(pollId);
        if (poll != null) {
            PollOption option = new PollOption();
            option.setPoll(poll);
            option.setOptionText(optionText);
            option.setDisplayOrder(displayOrder);
            return pollOptionRepository.save(option);
        }
        return null;
    }
    
    public Poll updatePoll(Long id, Poll pollDetails) {
        Optional<Poll> pollOpt = pollRepository.findById(id);
        if (pollOpt.isPresent()) {
            Poll poll = pollOpt.get();
            poll.setQuestion(pollDetails.getQuestion());
            poll.setActive(pollDetails.getActive());
            return pollRepository.save(poll);
        }
        return null;
    }
    
    public void deletePoll(Long id) {
        pollRepository.deleteById(id);
    }
    
    public void deleteOption(Long optionId) {
        pollOptionRepository.deleteById(optionId);
    }

    public PollOption addOption(PollOption option) {
        return pollOptionRepository.save(option);
    }


}
        
