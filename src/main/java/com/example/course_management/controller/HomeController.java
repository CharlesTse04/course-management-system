package com.example.course_management.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    

    
    // 移除 /login 映射，因為 AuthController 已經處理了
    // @GetMapping("/login")
    // public String login() {
    //     return "login";
    // }
    
}
