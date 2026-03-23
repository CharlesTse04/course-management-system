package com.example.course_management.controller;

import com.example.course_management.model.Lecture;
import com.example.course_management.model.Poll;
import com.example.course_management.repository.LectureRepository;
import com.example.course_management.repository.PollRepository;
import com.example.course_management.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class IndexController {
    
    @Autowired
    private LectureRepository lectureRepository;
    
    @Autowired
    private PollRepository pollRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @GetMapping({"/", "/index", "/home"})
    public String index(Model model, HttpSession session, 
                        @RequestParam(value = "lang", required = false) String lang) {
        System.out.println(">>> IndexController: Index page accessed <<<");
        
        // 處理語言切換
        if (lang != null) {
            session.setAttribute("lang", lang);
        }
        
        try {
            // 從數據庫獲取所有課程
            List<Lecture> lectures = lectureRepository.findAll();
            System.out.println("Lectures found: " + lectures.size());
            
            // 從數據庫獲取所有活躍的投票
            List<Poll> polls = pollRepository.findByActiveTrue();
            System.out.println("Active polls found: " + polls.size());
            
            // 獲取用戶數量
            long userCount = userRepository.count();
            
            // 添加數據到 Model
            model.addAttribute("lectures", lectures);
            model.addAttribute("totalLectures", lectures.size());
            model.addAttribute("polls", polls);
            model.addAttribute("totalPolls", polls.size());
            
            // 課程信息
            Map<String, String> course = new HashMap<>();
            course.put("name", "Advanced Web Development");
            course.put("description", "Master modern web development with Spring Boot, Jakarta EE, and cutting-edge technologies.");
            model.addAttribute("course", course);
            
            // 統計數據
            model.addAttribute("totalStudents", userCount);
            model.addAttribute("totalComments", 0);
            
            // 登入狀態
            Object userObj = session.getAttribute("user");
            model.addAttribute("isLoggedIn", userObj != null);
            if (userObj != null) {
                model.addAttribute("username", userObj.toString());
            }
            
        } catch (Exception e) {
            System.out.println("Error in IndexController: " + e.getMessage());
            e.printStackTrace();
        }
        
        return "index";
    }
}
