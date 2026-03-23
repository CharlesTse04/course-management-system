package com.example.course_management.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SimpleTestController {
    
    @GetMapping("/test-simple")
    public String testSimple() {
        System.out.println(">>> Simple test page accessed <<<");
        return "test-simple";
    }
}
