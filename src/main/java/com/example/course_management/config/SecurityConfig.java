
package com.example.course_management.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            // 所有請求都允許，不需要登入
            .authorizeHttpRequests(auth -> auth
                .anyRequest().permitAll()
            )
            // 關閉 CSRF
            .csrf(csrf -> csrf.disable())
            // 關閉表單登入
            .formLogin(form -> form.disable())
            // 關閉登出
            .logout(logout -> logout.disable());
        
        return http.build();
    }
}
