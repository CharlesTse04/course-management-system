package com.example.course_management.controller;

import com.example.course_management.model.Poll;
import com.example.course_management.model.PollOption;
import com.example.course_management.model.User;
import com.example.course_management.service.PollService;
import com.example.course_management.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.Optional;

@Controller
public class CreatePollController {
    
    @Autowired
    private PollService pollService;
    
    @Autowired
    private UserRepository userRepository;
    
    @GetMapping("/poll/create")
    public String createPollPage(HttpSession session, Model model) {
        // 檢查是否為教師
        String role = (String) session.getAttribute("role");
        if (!"TEACHER".equals(role)) {
            return "redirect:/";
        }
        
        return "create-poll";
    }
    
    @PostMapping("/poll/create")
    public String createPoll(@RequestParam String question,
                             @RequestParam String option1,
                             @RequestParam String option2,
                             @RequestParam String option3,
                             @RequestParam String option4,
                             @RequestParam String option5,
                             @RequestParam(defaultValue = "true") boolean active,
                             HttpSession session) {
        
        // 檢查是否為教師
        String role = (String) session.getAttribute("role");
        if (!"TEACHER".equals(role)) {
            return "redirect:/";
        }
        
        // 獲取當前用戶
        String username = (String) session.getAttribute("user");
        Optional<User> userOpt = userRepository.findByUsername(username);
        
        if (userOpt.isEmpty()) {
            return "redirect:/login";
        }
        
        // 創建投票
        Poll poll = new Poll();
        poll.setQuestion(question);
        poll.setActive(active);
        poll.setCreatedBy(userOpt.get());
        poll.setCreatedAt(LocalDateTime.now());
        poll.setUpdatedAt(LocalDateTime.now());
        
        // 保存投票
        Poll savedPoll = pollService.createPoll(poll);
        
        // 添加投票選項
        String[] options = {option1, option2, option3, option4, option5};
        int order = 1;
        for (String optionText : options) {
            if (optionText != null && !optionText.trim().isEmpty()) {
                PollOption option = new PollOption();
                option.setPoll(savedPoll);
                option.setOptionText(optionText);
                option.setDisplayOrder(order++);
                pollService.addOption(option);
            }
        }
        
        return "redirect:/poll?id=" + savedPoll.getId();
    }
}
