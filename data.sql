-- ============================================
-- Testing Data for Course Portal
-- ============================================

-- ============================================
-- 1. USERS (密碼: password，用 BCrypt 加密)
-- ============================================

-- Teacher Accounts
INSERT INTO users (username, password, full_name, email, phone, role, created_at, updated_at) VALUES
('teacher_chen', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE4lBo6oIWmJjGp22', '陳志明教授', 'chen@eduportal.com', '91234567', 'TEACHER', '2026-01-15 10:00:00', '2026-01-15 10:00:00'),
('teacher_wong', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE4lBo6oIWmJjGp22', '黃美玲博士', 'wong@eduportal.com', '92345678', 'TEACHER', '2026-01-20 11:30:00', '2026-01-20 11:30:00'),
('teacher_lee', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE4lBo6oIWmJjGp22', '李偉強教授', 'lee@eduportal.com', '93456789', 'TEACHER', '2026-02-01 09:15:00', '2026-02-01 09:15:00');

-- Student Accounts
INSERT INTO users (username, password, full_name, email, phone, role, created_at, updated_at) VALUES
('student_cheung', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE4lBo6oIWmJjGp22', '張小明', 'cheung@eduportal.com', '94567890', 'STUDENT', '2026-01-10 14:20:00', '2026-01-10 14:20:00'),
('student_chan', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE4lBo6oIWmJjGp22', '陳大文', 'chan@eduportal.com', '95678901', 'STUDENT', '2026-01-12 16:45:00', '2026-01-12 16:45:00'),
('student_wong', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE4lBo6oIWmJjGp22', '黃嘉欣', 'wong_stu@eduportal.com', '96789012', 'STUDENT', '2026-01-15 10:30:00', '2026-01-15 10:30:00'),
('student_lee', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE4lBo6oIWmJjGp22', '李志豪', 'lee_stu@eduportal.com', '97890123', 'STUDENT', '2026-01-18 13:15:00', '2026-01-18 13:15:00'),
('student_lam', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE4lBo6oIWmJjGp22', '林佩珊', 'lam@eduportal.com', '98901234', 'STUDENT', '2026-01-20 09:00:00', '2026-01-20 09:00:00'),
('student_ng', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE4lBo6oIWmJjGp22', '吳俊傑', 'ng@eduportal.com', '99012345', 'STUDENT', '2026-01-22 11:45:00', '2026-01-22 11:45:00'),
('student_tam', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE4lBo6oIWmJjGp22', '譚詠欣', 'tam@eduportal.com', '90123456', 'STUDENT', '2026-01-25 15:30:00', '2026-01-25 15:30:00'),
('student_liu', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE4lBo6oIWmJjGp22', '劉健明', 'liu@eduportal.com', '91234568', 'STUDENT', '2026-02-01 10:00:00', '2026-02-01 10:00:00');

-- ============================================
-- 2. LECTURES
-- ============================================

INSERT INTO lectures (title, description, detailed_summary, instructor_name, instructor_bio, created_at, updated_at, created_by) VALUES
('Spring Boot 入門與基礎', 
 '學習如何使用 Spring Boot 快速建立企業級 Web 應用程式', 
 '本講座涵蓋 Spring Boot 的核心概念，包括自動配置、起步依賴、嵌入式伺服器。透過實例演示如何建立第一個 REST API，並介紹 application.properties 的配置技巧。課程適合有 Java 基礎的開發者。',
 '陳志明教授', 
 '香港大學計算機科學系教授，專注於企業級 Java 開發，擁有 15 年教學經驗。',
 '2026-01-15 10:00:00', '2026-01-15 10:00:00', 1),

('Spring Data JPA 資料庫操作', 
 '深入學習 Spring Data JPA 與 Hibernate 整合', 
 '本講座介紹如何使用 Spring Data JPA 簡化資料庫操作。內容包括 Entity 映射、Repository 介面、自訂查詢方法、分頁與排序。透過實例演示 CRUD 操作及一對多關係的處理。',
 '陳志明教授', 
 '香港大學計算機科學系教授，專注於企業級 Java 開發，擁有 15 年教學經驗。',
 '2026-01-20 14:30:00', '2026-01-20 14:30:00', 1),

('Spring Security 安全框架', 
 '學習如何使用 Spring Security 保護你的 Web 應用', 
 '本講座詳細講解 Spring Security 的認證與授權機制。內容包括自訂 UserDetailsService、密碼加密、表單登入、角色權限控制、Remember-Me 功能。最後演示如何保護 REST API。',
 '黃美玲博士', 
 '資深軟體架構師，專注於應用程式安全領域，曾在多家金融機構擔任安全顧問。',
 '2026-01-25 09:00:00', '2026-01-25 09:00:00', 2),

('Spring MVC 與 Thymeleaf', 
 '學習 Spring MVC 架構與 Thymeleaf 模板引擎', 
 '本講座介紹 Spring MVC 的請求處理流程，包括 Controller、Model、View 的概念。同時深入講解 Thymeleaf 模板引擎的使用，包括表達式、條件判斷、迭代、片段重用等進階功能。',
 '黃美玲博士', 
 '資深軟體架構師，專注於應用程式安全領域，曾在多家金融機構擔任安全顧問。',
 '2026-02-01 14:00:00', '2026-02-01 14:00:00', 2),

('微服務架構入門', 
 '了解微服務架構的基本概念與 Spring Cloud 生態', 
 '本講座介紹微服務架構的核心理念，對比傳統單體應用。內容包括服務註冊與發現、配置中心、API 閘道、負載均衡、斷路器模式。透過 Spring Cloud 組件演示基本微服務架構。',
 '李偉強教授', 
 '科技大學計算機科學系副教授，研究領域包括雲計算與分散式系統。',
 '2026-02-05 11:00:00', '2026-02-05 11:00:00', 3),

('REST API 設計最佳實踐', 
 '學習如何設計優雅且易於維護的 REST API', 
 '本講座講解 RESTful API 的設計原則，包括資源命名、HTTP 方法選擇、狀態碼使用、版本控制、錯誤處理、API 文件撰寫。透過實例演示如何設計符合行業標準的 API。',
 '李偉強教授', 
 '科技大學計算機科學系副教授，研究領域包括雲計算與分散式系統。',
 '2026-02-10 15:30:00', '2026-02-10 15:30:00', 3);

-- ============================================
-- 3. MATERIALS (教材)
-- ============================================

-- Lecture 1: Spring Boot 入門
INSERT INTO materials (lecture_id, file_name, file_path, file_size, upload_date) VALUES
(1, 'spring-boot-intro-slides.pdf', '/uploads/lecture1/spring-boot-intro-slides.pdf', 2048000, '2026-01-15 11:00:00'),
(1, 'spring-boot-demo-code.zip', '/uploads/lecture1/spring-boot-demo-code.zip', 5120000, '2026-01-15 11:30:00'),
(1, 'spring-boot-exercises.pdf', '/uploads/lecture1/spring-boot-exercises.pdf', 512000, '2026-01-16 09:00:00');

-- Lecture 2: Spring Data JPA
INSERT INTO materials (lecture_id, file_name, file_path, file_size, upload_date) VALUES
(2, 'jpa-entity-mapping.pdf', '/uploads/lecture2/jpa-entity-mapping.pdf', 1536000, '2026-01-20 15:00:00'),
(2, 'jpa-repository-examples.zip', '/uploads/lecture2/jpa-repository-examples.zip', 3840000, '2026-01-21 10:00:00');

-- Lecture 3: Spring Security
INSERT INTO materials (lecture_id, file_name, file_path, file_size, upload_date) VALUES
(3, 'spring-security-guide.pdf', '/uploads/lecture3/spring-security-guide.pdf', 2560000, '2026-01-25 10:30:00'),
(3, 'security-demo-project.zip', '/uploads/lecture3/security-demo-project.zip', 6400000, '2026-01-26 14:00:00'),
(3, 'oauth2-example.zip', '/uploads/lecture3/oauth2-example.zip', 4200000, '2026-01-27 09:00:00');

-- Lecture 4: Spring MVC
INSERT INTO materials (lecture_id, file_name, file_path, file_size, upload_date) VALUES
(4, 'spring-mvc-architecture.pdf', '/uploads/lecture4/spring-mvc-architecture.pdf', 1280000, '2026-02-01 15:30:00'),
(4, 'thymeleaf-cheatsheet.pdf', '/uploads/lecture4/thymeleaf-cheatsheet.pdf', 256000, '2026-02-02 11:00:00');

-- Lecture 5: Microservices
INSERT INTO materials (lecture_id, file_name, file_path, file_size, upload_date) VALUES
(5, 'microservices-overview.pdf', '/uploads/lecture5/microservices-overview.pdf', 3072000, '2026-02-05 12:00:00'),
(5, 'spring-cloud-demo.zip', '/uploads/lecture5/spring-cloud-demo.zip', 8960000, '2026-02-06 16:00:00');

-- Lecture 6: REST API
INSERT INTO materials (lecture_id, file_name, file_path, file_size, upload_date) VALUES
(6, 'rest-api-best-practices.pdf', '/uploads/lecture6/rest-api-best-practices.pdf', 1792000, '2026-02-10 16:30:00'),
(6, 'openapi-spec-example.yaml', '/uploads/lecture6/openapi-spec-example.yaml', 128000, '2026-02-11 10:00:00');

-- ============================================
-- 4. POLLS (投票)
-- ============================================

INSERT INTO polls (question, active, created_at, updated_at, created_by) VALUES
('下堂課你想學咩主題？', true, '2026-02-01 09:00:00', '2026-02-01 09:00:00', 1),
('你認為邊個框架最適合做前端？', true, '2026-02-05 10:00:00', '2026-02-05 10:00:00', 2),
('Spring Boot 最實用嘅功能係？', true, '2026-02-10 14:00:00', '2026-02-10 14:00:00', 1),
('你更喜歡邊種資料庫？', true, '2026-02-15 11:30:00', '2026-02-15 11:30:00', 3),
('你對微服務架構嘅睇法？', true, '2026-02-20 09:00:00', '2026-02-20 09:00:00', 3);

-- ============================================
-- 5. POLL OPTIONS (投票選項)
-- ============================================

-- Poll 1: 下堂課主題
INSERT INTO poll_options (poll_id, option_text, display_order) VALUES
(1, 'Spring Cloud 微服務', 1),
(1, 'Spring Batch 批量處理', 2),
(1, 'WebFlux 反應式編程', 3),
(1, 'Spring Security 進階', 4),
(1, 'Testing with Spring Boot', 5);

-- Poll 2: 前端框架
INSERT INTO poll_options (poll_id, option_text, display_order) VALUES
(2, 'React', 1),
(2, 'Vue.js', 2),
(2, 'Angular', 3),
(2, 'Svelte', 4),
(2, 'HTMX (輕量級)', 5);

-- Poll 3: Spring Boot 最實用功能
INSERT INTO poll_options (poll_id, option_text, display_order) VALUES
(3, '自動配置 (Auto-configuration)', 1),
(3, '起步依賴 (Starter Dependencies)', 2),
(3, '嵌入式伺服器 (Embedded Server)', 3),
(3, 'Actuator 監控', 4),
(3, 'Spring Boot CLI', 5);

-- Poll 4: 資料庫偏好
INSERT INTO poll_options (poll_id, option_text, display_order) VALUES
(4, 'MySQL / MariaDB', 1),
(4, 'PostgreSQL', 2),
(4, 'MongoDB (NoSQL)', 3),
(4, 'H2 (開發測試用)', 4),
(4, 'Oracle', 5);

-- Poll 5: 微服務睇法
INSERT INTO poll_options (poll_id, option_text, display_order) VALUES
(5, '非常期待，想盡快學習', 1),
(5, '有興趣，但擔心複雜度', 2),
(5, '暫時唔需要，學好單體先', 3),
(5, '未決定，想了解更多', 4),
(5, '其他 (請留言分享)', 5);

-- ============================================
-- 6. VOTES (投票記錄)
-- ============================================

-- 學生投票記錄
-- Poll 1
INSERT INTO votes (user_id, poll_id, poll_option_id, voted_at, updated_at) VALUES
(4, 1, 1, '2026-02-02 10:00:00', '2026-02-02 10:00:00'),  -- 張小明 -> Spring Cloud
(5, 1, 2, '2026-02-02 11:30:00', '2026-02-02 11:30:00'),  -- 陳大文 -> Spring Batch
(6, 1, 3, '2026-02-02 14:15:00', '2026-02-02 14:15:00'),  -- 黃嘉欣 -> WebFlux
(7, 1, 1, '2026-02-03 09:45:00', '2026-02-03 09:45:00'),  -- 李志豪 -> Spring Cloud
(8, 1, 4, '2026-02-03 13:20:00', '2026-02-03 13:20:00'),  -- 林佩珊 -> Spring Security
(9, 1, 1, '2026-02-04 15:00:00', '2026-02-04 15:00:00'),  -- 吳俊傑 -> Spring Cloud
(10, 1, 5, '2026-02-04 16:30:00', '2026-02-04 16:30:00'); -- 譚詠欣 -> Testing

-- Poll 2
INSERT INTO votes (user_id, poll_id, poll_option_id, voted_at, updated_at) VALUES
(4, 2, 1, '2026-02-06 10:00:00', '2026-02-06 10:00:00'),  -- 張小明 -> React
(5, 2, 2, '2026-02-06 11:30:00', '2026-02-06 11:30:00'),  -- 陳大文 -> Vue.js
(6, 2, 1, '2026-02-07 09:15:00', '2026-02-07 09:15:00'),  -- 黃嘉欣 -> React
(7, 2, 3, '2026-02-07 14:45:00', '2026-02-07 14:45:00'),  -- 李志豪 -> Angular
(8, 2, 5, '2026-02-08 11:00:00', '2026-02-08 11:00:00'),  -- 林佩珊 -> HTMX
(9, 2, 2, '2026-02-08 15:30:00', '2026-02-08 15:30:00'),  -- 吳俊傑 -> Vue.js
(11, 2, 1, '2026-02-09 10:20:00', '2026-02-09 10:20:00'); -- 劉健明 -> React

-- Poll 3
INSERT INTO votes (user_id, poll_id, poll_option_id, voted_at, updated_at) VALUES
(4, 3, 1, '2026-02-11 09:00:00', '2026-02-11 09:00:00'),  -- 張小明 -> 自動配置
(5, 3, 2, '2026-02-11 14:30:00', '2026-02-11 14:30:00'),  -- 陳大文 -> 起步依賴
(6, 3, 1, '2026-02-12 10:15:00', '2026-02-12 10:15:00'),  -- 黃嘉欣 -> 自動配置
(7, 3, 3, '2026-02-12 16:00:00', '2026-02-12 16:00:00'),  -- 李志豪 -> 嵌入式伺服器
(8, 3, 4, '2026-02-13 11:45:00', '2026-02-13 11:45:00'),  -- 林佩珊 -> Actuator
(9, 3, 1, '2026-02-13 15:20:00', '2026-02-13 15:20:00'),  -- 吳俊傑 -> 自動配置
(10, 3, 2, '2026-02-14 09:30:00', '2026-02-14 09:30:00'); -- 譚詠欣 -> 起步依賴

-- Poll 4
INSERT INTO votes (user_id, poll_id, poll_option_id, voted_at, updated_at) VALUES
(4, 4, 2, '2026-02-16 10:00:00', '2026-02-16 10:00:00'),  -- 張小明 -> PostgreSQL
(5, 4, 1, '2026-02-16 14:30:00', '2026-02-16 14:30:00'),  -- 陳大文 -> MySQL
(6, 4, 3, '2026-02-17 09:45:00', '2026-02-17 09:45:00'),  -- 黃嘉欣 -> MongoDB
(7, 4, 2, '2026-02-17 15:20:00', '2026-02-17 15:20:00'),  -- 李志豪 -> PostgreSQL
(8, 4, 4, '2026-02-18 11:00:00', '2026-02-18 11:00:00'),  -- 林佩珊 -> H2
(9, 4, 2, '2026-02-18 16:15:00', '2026-02-18 16:15:00');  -- 吳俊傑 -> PostgreSQL

-- Poll 5
INSERT INTO votes (user_id, poll_id, poll_option_id, voted_at, updated_at) VALUES
(4, 5, 1, '2026-02-21 09:30:00', '2026-02-21 09:30:00'),  -- 張小明 -> 非常期待
(5, 5, 2, '2026-02-21 14:00:00', '2026-02-21 14:00:00'),  -- 陳大文 -> 有興趣但擔心
(6, 5, 3, '2026-02-22 10:45:00', '2026-02-22 10:45:00'),  -- 黃嘉欣 -> 暫時唔需要
(7, 5, 1, '2026-02-22 15:30:00', '2026-02-22 15:30:00'),  -- 李志豪 -> 非常期待
(8, 5, 4, '2026-02-23 11:15:00', '2026-02-23 11:15:00');  -- 林佩珊 -> 未決定

-- ============================================
-- 7. COMMENTS (留言)
-- ============================================

-- Lecture 1 留言 (Spring Boot 入門)
INSERT INTO comments (user_id, lecture_id, content, created_at, updated_at) VALUES
(4, 1, '好清楚嘅講解！特別係自動配置嘅部分，以前一直唔明，而家終於明白晒。', '2026-01-16 14:30:00', '2026-01-16 14:30:00'),
(5, 1, '請問有冇推薦嘅參考書？想深入學習 Spring Boot。', '2026-01-17 10:15:00', '2026-01-17 10:15:00'),
(2, 1, '多謝大家嘅支持！推薦可以睇 "Spring in Action" 呢本書。', '2026-01-17 16:00:00', '2026-01-17 16:00:00'),
(6, 1, 'Demo code 好有用，跟住做一次之後完全掌握基礎概念。', '2026-01-18 11:45:00', '2026-01-18 11:45:00'),
(7, 1, '希望可以有更多實戰例子，特別係同前端整合嘅部分。', '2026-01-19 09:30:00', '2026-01-19 09:30:00'),
(1, 1, '多謝建議！下堂課會增加前端整合嘅內容。', '2026-01-19 15:20:00', '2026-01-19 15:20:00');

-- Lecture 2 留言 (Spring Data JPA)
INSERT INTO comments (user_id, lecture_id, content, created_at, updated_at) VALUES
(4, 2, '一對多關係嘅部分講解得好好，清楚過我之前睇嘅教學。', '2026-01-21 14:00:00', '2026-01-21 14:00:00'),
(8, 2, '想問下點樣處理 N+1 query 問題？', '2026-01-22 10:30:00', '2026-01-22 10:30:00'),
(2, 2, '可以用 @EntityGraph 或者 fetch join 解決 N+1 問題，下堂會詳細講解。', '2026-01-22 16:45:00', '2026-01-22 16:45:00'),
(5, 2, 'JPA 嘅方法命名規則好方便，唔使寫 SQL 都做到複雜查詢。', '2026-01-23 09:15:00', '2026-01-23 09:15:00'),
(9, 2, '期待下一堂講更多關於查詢優化嘅內容。', '2026-01-24 11:00:00', '2026-01-24 11:00:00');

-- Lecture 3 留言 (Spring Security)
INSERT INTO comments (user_id, lecture_id, content, created_at, updated_at) VALUES
(4, 3, '終於學識點樣自訂登入頁面！之前一直用預設嘅好難睇。', '2026-01-26 13:30:00', '2026-01-26 13:30:00'),
(6, 3, 'BCrypt 密碼加密講解得好好，安全意識好重要。', '2026-01-27 10:00:00', '2026-01-27 10:00:00'),
(7, 3, '有冇機會學埋 OAuth2 同 JWT？', '2026-01-28 14:45:00', '2026-01-28 14:45:00'),
(3, 3, 'OAuth2 同 JWT 會喺進階課程涵蓋，多謝提議！', '2026-01-29 09:30:00', '2026-01-29 09:30:00'),
(10, 3, 'Role-based access control 嘅部分好實用，可以直接應用喺公司 project。', '2026-01-30 11:15:00', '2026-01-30 11:15:00');

-- Lecture 4 留言 (Spring MVC)
INSERT INTO comments (user_id, lecture_id, content, created_at, updated_at) VALUES
(5, 4, 'Thymeleaf 真係好易上手，比 JSP 方便好多。', '2026-02-02 15:00:00', '2026-02-02 15:00:00'),
(8, 4, '想問下點樣用 Thymeleaf 做國際化 (i18n)？', '2026-02-03 10:30:00', '2026-02-03 10:30:00'),
(2, 4, '可以透過 MessageSource 同 properties file 做 i18n，下次會補充呢部分。', '2026-02-03 16:00:00', '2026-02-03 16:00:00'),
(4, 4, 'Fragment 重用嘅功能好強大，唔使重複寫 header footer。', '2026-02-04 09:45:00', '2026-02-04 09:45:00');

-- Lecture 5 留言 (Microservices)
INSERT INTO comments (user_id, lecture_id, content, created_at, updated_at) VALUES
(6, 5, '微服務嘅概念好新，以前未接觸過，好有啟發性。', '2026-02-06 14:00:00', '2026-02-06 14:00:00'),
(7, 5, 'Eureka 同 Config Server 嘅 demo 好有用，跟住做一次就明。', '2026-02-07 11:30:00', '2026-02-07 11:30:00'),
(9, 5, '想問下實際生產環境用微服務嘅部署複雜嗎？', '2026-02-08 15:45:00', '2026-02-08 15:45:00'),
(3, 5, '生產部署通常配合 Docker 同 Kubernetes，可以大大簡化複雜度。', '2026-02-09 10:00:00', '2026-02-09 10:00:00'),
(11, 5, '期待下一堂講更多關於 API Gateway 嘅內容！', '2026-02-10 09:30:00', '2026-02-10 09:30:00');

-- Lecture 6 留言 (REST API)
INSERT INTO comments (user_id, lecture_id, content, created_at, updated_at) VALUES
(4, 6, '版本控制嘅部分好實用，之前成日遇到 API 變更嘅問題。', '2026-02-11 16:00:00', '2026-02-11 16:00:00'),
(8, 6, 'OpenAPI spec 可以自動生成文件，好方便團隊協作。', '2026-02-12 10:15:00', '2026-02-12 10:15:00'),
(5, 6, '錯誤處理嘅設計建議好有用，可以統一返 API 嘅 response format。', '2026-02-13 14:30:00', '2026-02-13 14:30:00'),
(10, 6, '有冇 sample code 可以參考埋 HATEOAS？', '2026-02-14 11:00:00', '2026-02-14 11:00:00'),
(2, 6, 'HATEOAS 嘅 sample 可以喺教材入面搵到，已經上載咗。', '2026-02-15 09:30:00', '2026-02-15 09:30:00');

-- Poll 1 留言 (下堂課主題)
INSERT INTO comments (user_id, poll_id, content, created_at, updated_at) VALUES
(4, 1, 'Spring Cloud 好吸引！想學微服務好耐。', '2026-02-02 12:00:00', '2026-02-02 12:00:00'),
(5, 1, '我覺得 Spring Security 進階都好重要，安全係基礎。', '2026-02-03 10:00:00', '2026-02-03 10:00:00'),
(2, 1, '大家嘅意見好好，我會綜合考慮安排課程內容。', '2026-02-04 09:00:00', '2026-02-04 09:00:00'),
(7, 1, 'WebFlux 反應式編程好新，想了解下點樣提升效能。', '2026-02-05 14:30:00', '2026-02-05 14:30:00');

-- Poll 2 留言 (前端框架)
INSERT INTO comments (user_id, poll_id, content, created_at, updated_at) VALUES
(6, 2, 'React 生態系最完善，搵工都容易啲。', '2026-02-06 15:00:00', '2026-02-06 15:00:00'),
(8, 2, 'Vue.js 上手快，對新手好 friendly。', '2026-02-07 11:30:00', '2026-02-07 11:30:00'),
(9, 2, 'HTMX 好輕量，配合 Spring Boot 好夾！', '2026-02-08 16:45:00', '2026-02-08 16:45:00'),
(3, 2, '我會根據投票結果決定下個課程嘅前端框架。', '2026-02-09 10:15:00', '2026-02-09 10:15:00');

-- Poll 3 留言 (Spring Boot 最實用功能)
INSERT INTO comments (user_id, poll_id, content, created_at, updated_at) VALUES
(4, 3, '自動配置真係好方便，大大減少咗 boilerplate code。', '2026-02-11 16:30:00', '2026-02-11 16:30:00'),
(7, 3, 'Actuator 好實用，可以監控 application 嘅健康狀況。', '2026-02-12 14:00:00', '2026-02-12 14:00:00'),
(11, 3, '起步依賴解決晒 dependency 衝突嘅問題！', '2026-02-13 09:45:00', '2026-02-13 09:45:00');

-- Poll 4 留言 (資料庫偏好)
INSERT INTO comments (user_id, poll_id, content, created_at, updated_at) VALUES
(5, 4, 'PostgreSQL 功能強大，open source 又好用。', '2026-02-17 10:30:00', '2026-02-17 10:30:00'),
(10, 4, 'MongoDB 喺某啲場景好適合，特別係 document 結構。', '2026-02-18 15:20:00', '2026-02-18 15:20:00'),
(2, 4, '建議大家可以根據 project 需求選擇合適嘅資料庫。', '2026-02-19 11:00:00', '2026-02-19 11:00:00');

-- Poll 5 留言 (微服務睇法)
INSERT INTO comments (user_id, poll_id, content, created_at, updated_at) VALUES
(4, 5, '好想快啲學微服務！公司準備轉型。', '2026-02-21 15:00:00', '2026-02-21 15:00:00'),
(6, 5, '微服務複雜度好高，要慎重考慮。', '2026-02-22 14:30:00', '2026-02-22 14:30:00'),
(9, 5, '學咗基本概念先，再逐步深入。', '2026-02-23 10:15:00', '2026-02-23 10:15:00');

-- ============================================
-- 8. 更新投票統計 (更新 votes count 方便查詢)
-- ============================================

-- 更新 poll_options 嘅 votes 統計 (可選，用於 quick access)
-- 實際應用中可以用查詢計算，呢度只係參考用

-- ============================================
-- 測試帳號總結
-- ============================================
-- 教師帳號:
--   teacher_chen / password
--   teacher_wong / password
--   teacher_lee / password
--
-- 學生帳號:
--   student_cheung / password
--   student_chan / password
--   student_wong / password
--   student_lee / password
--   student_lam / password
--   student_ng / password
--   student_tam / password
--   student_liu / password
--
-- 所有密碼都係: password
-- ============================================