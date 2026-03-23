package com.example.course_management.controller;

import com.example.course_management.model.Lecture;
import com.example.course_management.model.Comment;
import com.example.course_management.model.Material;
import com.example.course_management.service.LectureService;
import com.example.course_management.service.CommentService;
import com.example.course_management.service.MaterialService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class LectureController {
    
    @Autowired
    private LectureService lectureService;
    
    @Autowired
    private CommentService commentService;
    
    @Autowired
    private MaterialService materialService;

    @GetMapping("/materials/download/{id}")
    public ResponseEntity<Resource> downloadMaterial(@PathVariable Long id, HttpSession session) {
        // 檢查登入
        if (session.getAttribute("user") == null) {
            return ResponseEntity.status(HttpStatus.FOUND)
                    .header(HttpHeaders.LOCATION, "/login")
                    .build();
        }
        
        Material material = materialService.getMaterialById(id);
        if (material == null) {
            return ResponseEntity.notFound().build();
        }
        
        try {
            Path filePath = Paths.get(material.getFilePath());
            Resource resource = new UrlResource(filePath.toUri());
            
            if (!resource.exists()) {
                return ResponseEntity.notFound().build();
            }
            
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + material.getFileName() + "\"")
                    .body(resource);
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd MMM yyyy");
    
    @GetMapping("/lecture")
    public String lecturePage(@RequestParam("id") Long id, Model model, HttpSession session) {
        Lecture lecture = lectureService.getLectureById(id);
        if (lecture == null) {
            return "redirect:/";
        }
        
        model.addAttribute("lecture", lecture);
        
        // 獲取材料
        List<Material> materials = materialService.getMaterialsByLectureId(id);
        model.addAttribute("materials", materials);
        
        // 獲取評論
        List<Comment> comments = commentService.getCommentsByLectureId(id);
        model.addAttribute("comments", comments);
        
        // 登入狀態
        String username = (String) session.getAttribute("user");
        String role = (String) session.getAttribute("role");
        Long userId = (Long) session.getAttribute("userId");
        
        model.addAttribute("isLoggedIn", username != null);
        model.addAttribute("currentUser", username);
        model.addAttribute("currentUserId", userId);
        model.addAttribute("userRole", role);
        
        // 格式化日期
        if (lecture.getCreatedAt() != null) {
            model.addAttribute("formattedDate", lecture.getCreatedAt().format(DATE_FORMATTER));
        }
        
        model.addAttribute("materialCount", materials.size());
        model.addAttribute("commentCount", comments.size());
        
        return "lecture";
    }
    
    @PostMapping("/lecture/{id}/comment")
    public String addComment(@PathVariable Long id,
                             @RequestParam String content,
                             HttpSession session) {
        String username = (String) session.getAttribute("user");
        if (username == null) {
            return "redirect:/login";
        }
        
        commentService.addComment(id, username, content);
        return "redirect:/lecture?id=" + id;
    }
    
    @PostMapping("/comment/delete/{id}")
    public String deleteComment(@PathVariable Long id,
                                @RequestParam Long lectureId,
                                HttpSession session) {
        String username = (String) session.getAttribute("user");
        String role = (String) session.getAttribute("role");
        
        if (username != null) {
            commentService.deleteComment(id, username, role);
        }
        
        return "redirect:/lecture?id=" + lectureId;
    }
    
    @GetMapping("/lectures")
    public String lecturesPage(Model model, HttpSession session,
                               @RequestParam(value = "lang", required = false) String lang) {
        // 處理語言切換
        if (lang != null) {
            session.setAttribute("lang", lang);
        }
        
        // 獲取所有課程
        List<Lecture> lectures = lectureService.getAllLectures();
        
        // 為每個課程添加統計數據和格式化日期
        for (Lecture lecture : lectures) {
            // 材料數量
            int materialCount = materialService.getMaterialsByLectureId(lecture.getId()).size();
            lecture.setMaterialCount(materialCount);
            
            // 評論數量
            int commentCount = commentService.getCommentsByLectureId(lecture.getId()).size();
            lecture.setCommentCount(commentCount);
            
            // 格式化日期
            if (lecture.getCreatedAt() != null) {
                lecture.setFormattedCreatedAt(lecture.getCreatedAt().format(DATE_FORMATTER));
            }
        }
        
        model.addAttribute("lectures", lectures);
        model.addAttribute("totalLectures", lectures.size());
        
        // 登入狀態
        String username = (String) session.getAttribute("user");
        model.addAttribute("isLoggedIn", username != null);
        
        return "lectures";
    }
}
