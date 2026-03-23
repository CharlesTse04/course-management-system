package com.example.course_management.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/h2")
public class H2Controller {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    // 查看所有表
    @GetMapping("/tables")
    public List<String> getTables() {
        String sql = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'PUBLIC'";
        return jdbcTemplate.queryForList(sql, String.class);
    }
    
    // 查看用戶表
    @GetMapping("/users")
    public List<Map<String, Object>> getUsers() {
        String sql = "SELECT id, username, full_name, email, phone, role, created_at FROM users";
        return jdbcTemplate.queryForList(sql);
    }
    
    // 查看課程表
    @GetMapping("/lectures")
    public List<Map<String, Object>> getLectures() {
        String sql = "SELECT id, title, description, instructor_name, created_at FROM lectures";
        return jdbcTemplate.queryForList(sql);
    }
    
    // 查看投票表
    @GetMapping("/polls")
    public List<Map<String, Object>> getPolls() {
        String sql = "SELECT id, question, active, created_at FROM polls";
        return jdbcTemplate.queryForList(sql);
    }
    
    // 查看評論表
    @GetMapping("/comments")
    public List<Map<String, Object>> getComments() {
        String sql = "SELECT id, user_id, lecture_id, content, created_at FROM comments";
        return jdbcTemplate.queryForList(sql);
    }
    
    // 查看投票選項表
    @GetMapping("/poll-options")
    public List<Map<String, Object>> getPollOptions() {
        String sql = "SELECT id, poll_id, option_text, display_order FROM poll_options";
        return jdbcTemplate.queryForList(sql);
    }
    
    // 查看材料表
    @GetMapping("/materials")
    public List<Map<String, Object>> getMaterials() {
        String sql = "SELECT id, lecture_id, file_name, file_path, file_size FROM materials";
        return jdbcTemplate.queryForList(sql);
    }
    
    // 查看投票記錄表
    @GetMapping("/votes")
    public List<Map<String, Object>> getVotes() {
        String sql = "SELECT id, user_id, poll_id, poll_option_id, voted_at FROM votes";
        return jdbcTemplate.queryForList(sql);
    }
    
    // 執行自定義 SQL
    @GetMapping("/sql")
    public Map<String, Object> executeSql(@RequestParam String query) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Map<String, Object>> rows = jdbcTemplate.queryForList(query);
            result.put("success", true);
            result.put("data", rows);
            result.put("rowCount", rows.size());
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        return result;
    }
    
    // 數據庫統計
    @GetMapping("/stats")
    public Map<String, Long> getStats() {
        Map<String, Long> stats = new HashMap<>();
        stats.put("users", jdbcTemplate.queryForObject("SELECT COUNT(*) FROM users", Long.class));
        stats.put("lectures", jdbcTemplate.queryForObject("SELECT COUNT(*) FROM lectures", Long.class));
        stats.put("polls", jdbcTemplate.queryForObject("SELECT COUNT(*) FROM polls", Long.class));
        stats.put("poll_options", jdbcTemplate.queryForObject("SELECT COUNT(*) FROM poll_options", Long.class));
        stats.put("comments", jdbcTemplate.queryForObject("SELECT COUNT(*) FROM comments", Long.class));
        stats.put("materials", jdbcTemplate.queryForObject("SELECT COUNT(*) FROM materials", Long.class));
        stats.put("votes", jdbcTemplate.queryForObject("SELECT COUNT(*) FROM votes", Long.class));
        return stats;
    }
    
    // 數據庫信息
    @GetMapping("/info")
    public Map<String, Object> getDbInfo() {
        Map<String, Object> info = new HashMap<>();
        info.put("url", "jdbc:h2:mem:testdb");
        info.put("username", "sa");
        info.put("tables", getTables());
        info.put("stats", getStats());
        return info;
    }
}
