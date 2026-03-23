package com.example.course_management.controller;

import com.example.course_management.model.User;
import com.example.course_management.service.UserService;
import com.example.course_management.util.PasswordEncoderUtil;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class ProfileController {
    
    @Autowired
    private UserService userService;
    
    // 顯示個人資料頁面
    @GetMapping("/profile")
    public String profilePage(HttpSession session, Model model) {
        String username = (String) session.getAttribute("user");
        
        if (username == null) {
            return "redirect:/login";
        }
        
        Optional<User> userOpt = userService.getUserByUsername(username);
        
        if (userOpt.isPresent()) {
            model.addAttribute("user", userOpt.get());
            return "profile";
        }
        
        return "redirect:/login";
    }
    
    // 顯示編輯個人資料頁面
    @GetMapping("/profile/edit")
    public String editProfilePage(HttpSession session, Model model) {
        String username = (String) session.getAttribute("user");
        
        if (username == null) {
            return "redirect:/login";
        }
        
        Optional<User> userOpt = userService.getUserByUsername(username);
        
        if (userOpt.isPresent()) {
            model.addAttribute("user", userOpt.get());
            return "profile-edit";
        }
        
        return "redirect:/login";
    }
    
    // 更新個人資料
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam String fullName,
                                @RequestParam String email,
                                @RequestParam(required = false) String phone,
                                HttpSession session) {
        
        String username = (String) session.getAttribute("user");
        
        if (username == null) {
            return "redirect:/login";
        }
        
        Optional<User> userOpt = userService.getUserByUsername(username);
        
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone != null ? phone : "");
            
            userService.updateUser(user.getId(), user);
            
            // 更新 session 中的全名
            session.setAttribute("userFullName", fullName);
            
            return "redirect:/profile?success=true";
        }
        
        return "redirect:/profile?error=true";
    }
    
    // 修改密碼
    @PostMapping("/profile/change-password")
    public String changePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 HttpSession session) {
        
        String username = (String) session.getAttribute("user");
        
        if (username == null) {
            return "redirect:/login";
        }
        
        // 檢查新密碼和確認密碼是否一致
        if (!newPassword.equals(confirmPassword)) {
            return "redirect:/profile/edit?passwordError=mismatch";
        }
        
        Optional<User> userOpt = userService.getUserByUsername(username);
        
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            
            // 使用 UserService 的 updatePassword 方法
            boolean updated = userService.updatePassword(user.getId(), currentPassword, newPassword);
            
            if (updated) {
                return "redirect:/profile?passwordChanged=true";
            } else {
                return "redirect:/profile/edit?passwordError=invalid";
            }
        }
        
        return "redirect:/profile/edit?error=true";
    }
}
