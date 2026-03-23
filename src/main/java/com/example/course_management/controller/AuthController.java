package com.example.course_management.controller;

import com.example.course_management.model.User;
import com.example.course_management.repository.UserRepository;
import com.example.course_management.util.PasswordEncoderUtil;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class AuthController {
    
    @Autowired
    private UserRepository userRepository;
    
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }
    
    @PostMapping("/login")
    public String login(@RequestParam String username, 
                        @RequestParam String password,
                        HttpSession session) {
        
        System.out.println("=== Login Attempt ===");
        System.out.println("Username: " + username);
        
        Optional<User> userOpt = userRepository.findByUsername(username);
        
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            System.out.println("User found: " + user.getUsername());
            System.out.println("Full name: " + user.getFullName());
            
            if (PasswordEncoderUtil.matches(password, user.getPassword())) {
                // 設置 session 屬性
                session.setAttribute("user", user.getUsername());           // 用戶名
                session.setAttribute("userFullName", user.getFullName());   // 全名
                session.setAttribute("role", user.getRole());               // 角色
                session.setAttribute("userId", user.getId());              // 用戶 ID
                session.setAttribute("userEmail", user.getEmail());        // 郵箱
                
                System.out.println("Login SUCCESS!");
                return "redirect:/";
            }
        }
        
        System.out.println("Login FAILED!");
        return "redirect:/login?error=true";
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
