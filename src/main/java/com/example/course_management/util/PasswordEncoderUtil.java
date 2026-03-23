package com.example.course_management.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class PasswordEncoderUtil {
    
    private static final PasswordEncoder encoder = new BCryptPasswordEncoder();
    
    public static String encode(String rawPassword) {
        return encoder.encode(rawPassword);
    }
    
    public static boolean matches(String rawPassword, String encodedPassword) {
        if (rawPassword == null || encodedPassword == null) {
            return false;
        }
        boolean result = encoder.matches(rawPassword, encodedPassword);
        System.out.println("PasswordEncoderUtil.matches() called");
        System.out.println("  raw: " + rawPassword);
        System.out.println("  encoded: " + encodedPassword);
        System.out.println("  result: " + result);
        return result;
    }
    
    public static void main(String[] args) {
        String password = "password";
        String testHash = "$2a$10$9O/oJuo3NelPoTk0ECSph.Rz2XsVYGFbufFvL8GcSfZOw5mYskN8m";
        System.out.println("Test: " + matches(password, testHash));
    }
}
