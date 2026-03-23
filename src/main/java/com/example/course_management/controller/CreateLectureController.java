package com.example.course_management.controller;

import com.example.course_management.model.Lecture;
import com.example.course_management.model.Material;
import com.example.course_management.model.User;
import com.example.course_management.service.LectureService;
import com.example.course_management.service.MaterialService;
import com.example.course_management.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Controller
public class CreateLectureController {
    
    @Autowired
    private LectureService lectureService;
    
    @Autowired
    private MaterialService materialService;
    
    @Autowired
    private UserRepository userRepository;
    
    @GetMapping("/lecture/create")
    public String createLecturePage(HttpSession session, Model model) {
        // 檢查是否為教師
        String role = (String) session.getAttribute("role");
        if (!"TEACHER".equals(role)) {
            return "redirect:/";
        }
        
        return "create-lecture";
    }
    
    @PostMapping("/lecture/create")
    public String createLecture(@RequestParam String title,
                                @RequestParam String description,
                                @RequestParam(required = false) String detailedSummary,
                                @RequestParam(required = false) String instructorName,
                                @RequestParam(required = false) String instructorBio,
                                @RequestParam(required = false) MultipartFile[] materials,
                                HttpSession session) throws IOException {
        
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
        
        // 創建課程
        Lecture lecture = new Lecture();
        lecture.setTitle(title);
        lecture.setDescription(description);
        lecture.setDetailedSummary(detailedSummary != null ? detailedSummary : description);
        lecture.setInstructorName(instructorName != null ? instructorName : userOpt.get().getFullName());
        lecture.setInstructorBio(instructorBio != null ? instructorBio : "");
        lecture.setCreatedBy(userOpt.get());
        lecture.setCreatedAt(LocalDateTime.now());
        lecture.setUpdatedAt(LocalDateTime.now());
        
        // 保存課程
        Lecture savedLecture = lectureService.createLecture(lecture);
        
        // 處理材料上傳並保存到數據庫
        if (materials != null && materials.length > 0) {
            String uploadDir = "uploads/lectures/" + savedLecture.getId();
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            for (MultipartFile file : materials) {
                if (!file.isEmpty()) {
                    // 生成唯一文件名
                    String originalFileName = file.getOriginalFilename();
                    String fileName = UUID.randomUUID().toString() + "_" + originalFileName;
                    Path path = Paths.get(uploadDir, fileName);
                    Files.write(path, file.getBytes());
                    
                    // 保存材料記錄到數據庫
                    Material material = new Material();
                    material.setLectureId(savedLecture.getId());
                    material.setFileName(originalFileName);
                    material.setFilePath(path.toString());
                    material.setFileSize(file.getSize());
                    material.setUploadDate(LocalDateTime.now());
                    
                    materialService.addMaterial(material);
                }
            }
        }
        
        return "redirect:/lecture?id=" + savedLecture.getId();
    }
}
