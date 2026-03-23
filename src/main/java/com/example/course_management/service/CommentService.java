package com.example.course_management.service;

import com.example.course_management.model.Comment;
import com.example.course_management.model.Lecture;
import com.example.course_management.model.Poll;
import com.example.course_management.model.User;
import com.example.course_management.repository.CommentRepository;
import com.example.course_management.repository.LectureRepository;
import com.example.course_management.repository.PollRepository;
import com.example.course_management.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class CommentService {
    
    @Autowired
    private CommentRepository commentRepository;
    
    @Autowired
    private LectureRepository lectureRepository;
    
    @Autowired
    private PollRepository pollRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    // Lecture Comments
    public List<Comment> getCommentsByLectureId(Long lectureId) {
        return commentRepository.findByLectureId(lectureId);
    }
    
    public Comment addComment(Long lectureId, String username, String content) {
        Optional<Lecture> lectureOpt = lectureRepository.findById(lectureId);
        Optional<User> userOpt = userRepository.findByUsername(username);
        
        if (lectureOpt.isPresent() && userOpt.isPresent()) {
            Comment comment = new Comment();
            comment.setLecture(lectureOpt.get());
            comment.setUser(userOpt.get());
            comment.setContent(content);
            comment.setCreatedAt(LocalDateTime.now());
            comment.setUpdatedAt(LocalDateTime.now());
            return commentRepository.save(comment);
        }
        return null;
    }
    
    // Poll Comments
    public List<Comment> getCommentsByPollId(Long pollId) {
        return commentRepository.findByPollId(pollId);
    }
    
    public Comment addPollComment(Long pollId, String username, String content) {
        Optional<Poll> pollOpt = pollRepository.findById(pollId);
        Optional<User> userOpt = userRepository.findByUsername(username);
        
        if (pollOpt.isPresent() && userOpt.isPresent()) {
            Comment comment = new Comment();
            comment.setPoll(pollOpt.get());
            comment.setUser(userOpt.get());
            comment.setContent(content);
            comment.setCreatedAt(LocalDateTime.now());
            comment.setUpdatedAt(LocalDateTime.now());
            return commentRepository.save(comment);
        }
        return null;
    }
    
    // General
    public List<Comment> getCommentsByUsername(String username) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isPresent()) {
            return commentRepository.findByUserId(userOpt.get().getId());
        }
        return List.of();
    }
    
    public Comment updateComment(Long id, String content, String username) {
        Optional<Comment> commentOpt = commentRepository.findById(id);
        if (commentOpt.isPresent()) {
            Comment comment = commentOpt.get();
            if (comment.getUser().getUsername().equals(username)) {
                comment.setContent(content);
                comment.setUpdatedAt(LocalDateTime.now());
                return commentRepository.save(comment);
            }
        }
        return null;
    }
    
    public boolean deleteComment(Long id, String username, String role) {
        Optional<Comment> commentOpt = commentRepository.findById(id);
        if (commentOpt.isPresent()) {
            Comment comment = commentOpt.get();
            if ("TEACHER".equals(role) || comment.getUser().getUsername().equals(username)) {
                commentRepository.deleteById(id);
                return true;
            }
        }
        return false;
    }
}
