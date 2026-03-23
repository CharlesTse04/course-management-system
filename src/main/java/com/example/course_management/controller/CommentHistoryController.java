package com.example.course_management.controller;

import com.example.course_management.dto.CommentHistoryDTO;
import com.example.course_management.dto.WordCloudDTO;
import com.example.course_management.model.Comment;
import com.example.course_management.service.CommentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/comment-history")
public class CommentHistoryController {
    
    @Autowired
    private CommentService commentService;
    
    // 日期格式化器
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm");
    private static final DateTimeFormatter DATE_ONLY_FORMATTER = DateTimeFormatter.ofPattern("dd MMM yyyy");
    
    @GetMapping
    public String commentHistoryPage(Model model, HttpSession session) {
        String username = (String) session.getAttribute("user");
        
        if (username == null) {
            return "redirect:/login";
        }
        
        List<Comment> comments = commentService.getCommentsByUsername(username);
        
        List<CommentHistoryDTO> historyList = comments.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
        
        long totalComments = historyList.size();
        long lectureComments = historyList.stream()
                .filter(c -> "LECTURE".equals(c.getSourceType()))
                .count();
        long pollComments = historyList.stream()
                .filter(c -> "POLL".equals(c.getSourceType()))
                .count();
        
        double avgPerMonth = calculateAvgPerMonth(comments);
        int engagementStars = calculateEngagementStars(totalComments);
        String engagementLevel = getEngagementLevel(totalComments);
        List<WordCloudDTO> wordCloud = generateWordCloud(comments);
        
        model.addAttribute("commentHistory", historyList);
        model.addAttribute("totalComments", totalComments);
        model.addAttribute("lectureComments", lectureComments);
        model.addAttribute("pollComments", pollComments);
        model.addAttribute("avgCommentsPerMonth", avgPerMonth);
        model.addAttribute("engagementStars", engagementStars);
        model.addAttribute("engagementLevel", engagementLevel);
        model.addAttribute("wordCloud", wordCloud);
        
        return "comment-history";
    }
    
    private CommentHistoryDTO convertToDTO(Comment comment) {
        CommentHistoryDTO dto = new CommentHistoryDTO();
        dto.setId(comment.getId());
        dto.setContent(comment.getContent());
        dto.setCreatedAt(comment.getCreatedAt());
        // 將 LocalDateTime 轉換為格式化字符串
        dto.setFormattedDate(comment.getCreatedAt().format(DATE_FORMATTER));
        dto.setFormattedDateOnly(comment.getCreatedAt().format(DATE_ONLY_FORMATTER));
        dto.setTimeAgo(getTimeAgo(comment.getCreatedAt()));
        
        if (comment.getLecture() != null) {
            dto.setSourceType("LECTURE");
            dto.setSourceTitle(comment.getLecture().getTitle());
            dto.setSourceUrl("/lecture?id=" + comment.getLecture().getId());
        } else if (comment.getPoll() != null) {
            dto.setSourceType("POLL");
            dto.setSourceTitle(comment.getPoll().getQuestion());
            dto.setSourceUrl("/poll?id=" + comment.getPoll().getId());
        }
        
        return dto;
    }
    
    private String getTimeAgo(LocalDateTime dateTime) {
        LocalDateTime now = LocalDateTime.now();
        long diffMinutes = java.time.Duration.between(dateTime, now).toMinutes();
        
        if (diffMinutes < 1) return "just now";
        if (diffMinutes < 60) return diffMinutes + " minutes ago";
        if (diffMinutes < 1440) return (diffMinutes / 60) + " hours ago";
        if (diffMinutes < 10080) return (diffMinutes / 1440) + " days ago";
        return dateTime.format(DATE_ONLY_FORMATTER);
    }
    
    private double calculateAvgPerMonth(List<Comment> comments) {
        if (comments.isEmpty()) return 0;
        LocalDateTime earliest = comments.stream()
                .map(Comment::getCreatedAt)
                .min(LocalDateTime::compareTo)
                .orElse(LocalDateTime.now());
        long months = java.time.Duration.between(earliest, LocalDateTime.now()).toDays() / 30;
        if (months < 1) months = 1;
        return (double) comments.size() / months;
    }
    
    private int calculateEngagementStars(long totalComments) {
        if (totalComments >= 50) return 5;
        if (totalComments >= 30) return 4;
        if (totalComments >= 15) return 3;
        if (totalComments >= 5) return 2;
        if (totalComments >= 1) return 1;
        return 0;
    }
    
    private String getEngagementLevel(long totalComments) {
        if (totalComments >= 50) return "Super Contributor";
        if (totalComments >= 30) return "Active Participant";
        if (totalComments >= 15) return "Regular Commenter";
        if (totalComments >= 5) return "Getting Started";
        if (totalComments >= 1) return "Newcomer";
        return "No Activity";
    }
    
    private List<WordCloudDTO> generateWordCloud(List<Comment> comments) {
        String allText = comments.stream()
                .map(Comment::getContent)
                .collect(Collectors.joining(" "))
                .toLowerCase();
        
        Set<String> stopWords = Set.of("the", "a", "an", "and", "or", "but", "in", "on", "at", "to", "for", 
                "of", "with", "by", "is", "are", "was", "were", "this", "that", "i", "me", "my", "you", "your");
        
        Map<String, Integer> wordCount = new HashMap<>();
        String[] words = allText.split("\\W+");
        
        for (String word : words) {
            if (word.length() > 2 && !stopWords.contains(word)) {
                wordCount.put(word, wordCount.getOrDefault(word, 0) + 1);
            }
        }
        
        return wordCount.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .limit(20)
                .map(entry -> new WordCloudDTO(entry.getKey(), Math.min(28, 12 + entry.getValue() * 2)))
                .collect(Collectors.toList());
    }
}
