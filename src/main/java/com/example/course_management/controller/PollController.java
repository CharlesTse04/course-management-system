package com.example.course_management.controller;

import com.example.course_management.model.Poll;
import com.example.course_management.model.PollOption;
import com.example.course_management.model.Comment;
import com.example.course_management.model.Vote;
import com.example.course_management.service.PollService;
import com.example.course_management.service.CommentService;
import com.example.course_management.service.VoteService;
import com.example.course_management.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class PollController {
    
    @Autowired
    private PollService pollService;
    
    @Autowired
    private CommentService commentService;
    
    @Autowired
    private VoteService voteService;
    
    @Autowired
    private UserRepository userRepository;
    
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd MMM yyyy");
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm");
    
    @GetMapping("/poll")
    public String pollPage(@RequestParam("id") Long id, 
                           @RequestParam(value = "lang", required = false) String lang,
                           Model model, 
                           HttpSession session) {
        System.out.println(">>> PollController: poll page accessed, id: " + id);
        
        // 處理語言切換
        if (lang != null) {
            session.setAttribute("lang", lang);
        }
        
        Poll poll = pollService.getPollById(id);
        if (poll == null) {
            return "redirect:/";
        }
        
        model.addAttribute("poll", poll);
        
        // 獲取投票選項
        List<PollOption> options = pollService.getOptionsByPollId(id);
        model.addAttribute("options", options);
        
        // 計算總票數
        int totalVotes = options.stream().mapToInt(option -> {
            if (option.getVotes() != null) {
                return option.getVotes().size();
            }
            return 0;
        }).sum();
        model.addAttribute("totalVotes", totalVotes);
        
        // 格式化日期
        if (poll.getCreatedAt() != null) {
            model.addAttribute("formattedDate", poll.getCreatedAt().format(DATE_FORMATTER));
        }
        
        // 獲取評論並格式化日期
        List<Comment> comments = commentService.getCommentsByPollId(id);
        for (Comment comment : comments) {
            if (comment.getCreatedAt() != null) {
                comment.setFormattedCreatedAt(comment.getCreatedAt().format(DATE_TIME_FORMATTER));
            }
        }
        model.addAttribute("comments", comments);
        
        // 登入狀態
        String username = (String) session.getAttribute("user");
        Long userId = (Long) session.getAttribute("userId");
        
        model.addAttribute("isLoggedIn", username != null);
        model.addAttribute("currentUser", username);
        model.addAttribute("currentUserId", userId);
        
        // 獲取用戶的投票
        if (username != null && userId != null) {
            Vote userVote = voteService.getUserVoteByPollId(userId, id);
            model.addAttribute("userVote", userVote);
        }
        
        return "poll";
    }
    
    @PostMapping("/poll/{id}/vote")
    public String vote(@PathVariable Long id,
                       @RequestParam Long optionId,
                       HttpSession session) {
        String username = (String) session.getAttribute("user");
        Long userId = (Long) session.getAttribute("userId");
        
        if (username == null) {
            return "redirect:/login";
        }
        
        voteService.saveVote(userId, id, optionId);
        return "redirect:/poll?id=" + id;
    }
    
    @PostMapping("/poll/{id}/comment")
    public String addComment(@PathVariable Long id,
                             @RequestParam String content,
                             HttpSession session) {
        String username = (String) session.getAttribute("user");
        if (username == null) {
            return "redirect:/login";
        }
        
        commentService.addPollComment(id, username, content);
        return "redirect:/poll?id=" + id;
    }
    
    @PostMapping("/poll/comment/delete/{id}")
    public String deleteComment(@PathVariable Long id,
                                @RequestParam Long pollId,
                                HttpSession session) {
        String username = (String) session.getAttribute("user");
        String role = (String) session.getAttribute("role");
        
        if (username != null) {
            commentService.deleteComment(id, username, role);
        }
        
        return "redirect:/poll?id=" + pollId;
    }
    
    @GetMapping("/polls")
    public String pollsPage(Model model, HttpSession session,
                            @RequestParam(value = "lang", required = false) String lang) {
        // 處理語言切換
        if (lang != null) {
            session.setAttribute("lang", lang);
        }
        
        // 獲取所有投票
        List<Poll> polls = pollService.getAllPolls();
        
        // 為每個投票添加統計數據和格式化日期
        for (Poll poll : polls) {
            // 評論數量
            int commentCount = commentService.getCommentsByPollId(poll.getId()).size();
            poll.setCommentCount(commentCount);
            
            // 總票數
            int totalVotes = 0;
            List<PollOption> options = pollService.getOptionsByPollId(poll.getId());
            for (PollOption option : options) {
                if (option.getVotes() != null) {
                    totalVotes += option.getVotes().size();
                }
            }
            poll.setTotalVotes(totalVotes);
            
            // 格式化日期
            if (poll.getCreatedAt() != null) {
                poll.setFormattedCreatedAt(poll.getCreatedAt().format(DATE_FORMATTER));
            }
        }
        
        // 分離活躍投票和已結束投票
        List<Poll> activePolls = polls.stream()
                .filter(Poll::getActive)
                .collect(Collectors.toList());
        List<Poll> inactivePolls = polls.stream()
                .filter(p -> !p.getActive())
                .collect(Collectors.toList());
        
        model.addAttribute("activePolls", activePolls);
        model.addAttribute("inactivePolls", inactivePolls);
        model.addAttribute("totalPolls", polls.size());
        
        // 登入狀態
        String username = (String) session.getAttribute("user");
        model.addAttribute("isLoggedIn", username != null);
        
        return "polls";
    }
}
