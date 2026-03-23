package com.example.course_management.controller;

import com.example.course_management.model.Lecture;
import com.example.course_management.model.Comment;
import com.example.course_management.model.Poll;
import com.example.course_management.model.User;
import com.example.course_management.repository.LectureRepository;
import com.example.course_management.repository.CommentRepository;
import com.example.course_management.repository.PollRepository;
import com.example.course_management.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/test")
public class TestController {
    
    @Autowired
    private LectureRepository lectureRepository;
    
    @Autowired
    private CommentRepository commentRepository;
    
    @Autowired
    private PollRepository pollRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @GetMapping("/data")
    public Map<String, Object> showAllData() {
        Map<String, Object> result = new HashMap<>();
        
        // 獲取所有數據
        List<Lecture> lectures = lectureRepository.findAll();
        List<Comment> comments = commentRepository.findAll();
        List<Poll> polls = pollRepository.findAll();
        List<User> users = userRepository.findAll();
        
        result.put("lectures", lectures);
        result.put("lecturesCount", lectures.size());
        result.put("comments", comments);
        result.put("commentsCount", comments.size());
        result.put("polls", polls);
        result.put("pollsCount", polls.size());
        result.put("users", users);
        result.put("usersCount", users.size());
        
        return result;
    }
    
    @GetMapping("/lectures")
    public List<Lecture> getAllLectures() {
        return lectureRepository.findAll();
    }
    
    @GetMapping("/comments")
    public List<Comment> getAllComments() {
        return commentRepository.findAll();
    }
    
    @GetMapping("/polls")
    public List<Poll> getAllPolls() {
        return pollRepository.findAll();
    }
    
    @GetMapping("/users")
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
    
    @GetMapping("/counts")
    public Map<String, Long> getCounts() {
        Map<String, Long> counts = new HashMap<>();
        counts.put("lectures", lectureRepository.count());
        counts.put("comments", commentRepository.count());
        counts.put("polls", pollRepository.count());
        counts.put("users", userRepository.count());
        return counts;
    }
}
