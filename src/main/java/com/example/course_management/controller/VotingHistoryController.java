package com.example.course_management.controller;

import com.example.course_management.dto.VotingHistoryDTO;
import com.example.course_management.model.Vote;
import com.example.course_management.model.Poll;
import com.example.course_management.model.PollOption;
import com.example.course_management.service.VoteService;
import com.example.course_management.service.PollService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/voting-history")
public class VotingHistoryController {
    
    @Autowired
    private VoteService voteService;
    
    @Autowired
    private PollService pollService;
    
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm");
    private static final DateTimeFormatter DATE_ONLY_FORMATTER = DateTimeFormatter.ofPattern("dd MMM yyyy");
    
    @GetMapping
    public String votingHistoryPage(Model model, HttpSession session,
                                    @RequestParam(value = "lang", required = false) String lang) {
        // 處理語言切換
        if (lang != null) {
            session.setAttribute("lang", lang);
        }
        
        Long userId = (Long) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/login";
        }
        
        // 獲取用戶的所有投票
        List<Vote> votes = voteService.getVotesByUserId(userId);
        
        // 轉換為 DTO
        List<VotingHistoryDTO> historyList = new ArrayList<>();
        
        // 找出每個投票的最新投票
        Map<Long, Vote> latestVotes = new HashMap<>();
        for (Vote vote : votes) {
            Long pollId = vote.getPollId();
            Vote existing = latestVotes.get(pollId);
            if (existing == null || vote.getUpdatedAt().isAfter(existing.getUpdatedAt())) {
                latestVotes.put(pollId, vote);
            }
        }
        
        // 轉換所有投票記錄
        for (Vote vote : votes) {
            VotingHistoryDTO dto = new VotingHistoryDTO();
            dto.setPollId(vote.getPollId());
            dto.setVotedAt(vote.getUpdatedAt());
            // 格式化日期為字符串
            dto.setFormattedVotedAt(vote.getUpdatedAt().format(DATE_FORMATTER));
            
            // 獲取投票問題
            Poll poll = pollService.getPollById(vote.getPollId());
            if (poll != null) {
                dto.setPollQuestion(poll.getQuestion());
            }
            
            // 獲取選項文字
            PollOption option = pollService.getOptionById(vote.getPollOptionId());
            if (option != null) {
                dto.setSelectedOption(option.getOptionText());
            }
            
            // 判斷是否為最新投票
            Vote latest = latestVotes.get(vote.getPollId());
            dto.setCurrent(latest != null && latest.getId().equals(vote.getId()));
            
            historyList.add(dto);
        }
        
        // 按時間倒序排列
        historyList.sort((a, b) -> b.getVotedAt().compareTo(a.getVotedAt()));
        
        // 計算統計數據
        int totalVotes = historyList.size();
        int activePolls = pollService.getActivePolls().size();
        
        // 計算參與率
        int totalPolls = pollService.getAllPolls().size();
        double participationRate = totalPolls > 0 ? (totalVotes * 100.0 / totalPolls) : 0;
        
        model.addAttribute("votingHistory", historyList);
        model.addAttribute("totalVotes", totalVotes);
        model.addAttribute("participationRate", Math.round(participationRate));
        model.addAttribute("activePolls", activePolls);
        
        return "voting-history";
    }
}
