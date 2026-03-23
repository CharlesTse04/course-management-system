package com.example.course_management.controller;

import com.example.course_management.model.User;
import com.example.course_management.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RegisterController {
    
    @Autowired
    private UserService userService;
    
    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }
    
    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String password,
                           @RequestParam String fullName,
                           @RequestParam String email,
                           @RequestParam(required = false) String phone,
                           HttpSession session) {
        
        System.out.println("=== Registration Attempt ===");
        System.out.println("Username: " + username);
        System.out.println("Email: " + email);
        System.out.println("Full Name: " + fullName);
        
        try {
            // 檢查用戶名是否已存在
            if (userService.existsByUsername(username)) {
                System.out.println("Username already exists: " + username);
                return "redirect:/register?error=username";
            }
            
            // 檢查郵箱是否已存在
            if (userService.existsByEmail(email)) {
                System.out.println("Email already exists: " + email);
                return "redirect:/register?error=email";
            }
            
            // 創建新用戶（密碼會由 Service 自動加密）
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(password);  // 明文密碼，Service 會自動加密
            newUser.setFullName(fullName);
            newUser.setEmail(email);
            newUser.setPhone(phone != null ? phone : "");
            newUser.setRole("STUDENT");  // 預設角色為學生
            
            // 保存到數據庫
            User savedUser = userService.createUser(newUser);
            
            System.out.println("Registration SUCCESS! User ID: " + savedUser.getId());
            
            // 註冊成功後自動登入
            session.setAttribute("user", savedUser.getUsername());
            session.setAttribute("userFullName", savedUser.getFullName());
            session.setAttribute("role", savedUser.getRole());
            session.setAttribute("userId", savedUser.getId());
            session.setAttribute("userEmail", savedUser.getEmail());
            
            return "redirect:/?registered=true";
            
        } catch (Exception e) {
            System.out.println("Registration FAILED: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/register?error=true";
        }
    }
}
