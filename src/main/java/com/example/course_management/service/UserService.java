package com.example.course_management.service;

import com.example.course_management.model.User;
import com.example.course_management.repository.UserRepository;
import com.example.course_management.util.PasswordEncoderUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    // 獲取所有用戶
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
    
    // 根據 ID 獲取用戶
    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }
    
    // 根據用戶名獲取用戶
    public Optional<User> getUserByUsername(String username) {
        return userRepository.findByUsername(username);
    }
    
    // 根據郵箱獲取用戶
    public Optional<User> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    // 創建用戶（註冊）
    public User createUser(User user) {
        // 加密密碼
        user.setPassword(PasswordEncoderUtil.encode(user.getPassword()));
        return userRepository.save(user);
    }
    
    // 更新用戶信息
    public User updateUser(Long id, User userDetails) {
        Optional<User> userOpt = userRepository.findById(id);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setFullName(userDetails.getFullName());
            user.setEmail(userDetails.getEmail());
            user.setPhone(userDetails.getPhone());
            return userRepository.save(user);
        }
        return null;
    }
    
    // 更新密碼
    public boolean updatePassword(Long id, String oldPassword, String newPassword) {
        Optional<User> userOpt = userRepository.findById(id);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (PasswordEncoderUtil.matches(oldPassword, user.getPassword())) {
                user.setPassword(PasswordEncoderUtil.encode(newPassword));
                userRepository.save(user);
                return true;
            }
        }
        return false;
    }
    
    // 刪除用戶
    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }
    
    // 檢查用戶名是否存在
    public boolean existsByUsername(String username) {
        return userRepository.existsByUsername(username);
    }
    
    // 檢查郵箱是否存在
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }
    
    // 獲取學生數量
    public long countStudents() {
        return userRepository.countByRole("STUDENT");
    }
    
    // 獲取教師數量
    public long countTeachers() {
        return userRepository.countByRole("TEACHER");
    }
    
    // 驗證登入
    public Optional<User> authenticate(String username, String password) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (PasswordEncoderUtil.matches(password, user.getPassword())) {
                return userOpt;
            }
        }
        return Optional.empty();
    }
}
