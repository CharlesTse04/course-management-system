<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title th:text="${lecture.title} + ' - Course Portal'">Spring Boot Fundamentals - Course Portal</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        /* ========== GLOBAL STYLES ========== */
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --light-bg: #f8f9fa;
            --dark-bg: #2c3e50;
            --border-radius: 12px;
            --box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            --transition: all 0.3s ease;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }
        
        /* ========== NAVIGATION ========== */
        .custom-navbar {
            background: linear-gradient(135deg, var(--primary-color), #34495e);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 1rem 0;
        }
        
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 600;
            color: white !important;
            letter-spacing: 1px;
        }
        
        .navbar-brand i {
            color: var(--secondary-color);
        }
        
        .nav-link {
            color: rgba(255,255,255,0.85) !important;
            font-weight: 500;
            transition: var(--transition);
        }
        
        .nav-link:hover {
            color: white !important;
            transform: translateY(-2px);
        }
        
        .language-btn {
            background: rgba(255,255,255,0.15);
            border: 1px solid rgba(255,255,255,0.3);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 30px;
            transition: var(--transition);
            text-decoration: none;
            display: inline-block;
        }
        
        .language-btn:hover {
            background: rgba(255,255,255,0.25);
            transform: translateY(-2px);
            color: white;
        }
        
        .btn-login {
            background: transparent;
            border: 2px solid rgba(255,255,255,0.3);
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 30px;
            transition: var(--transition);
            text-decoration: none;
        }
        
        .btn-login:hover {
            background: white;
            color: var(--primary-color);
            border-color: white;
        }
        
        .btn-register {
            background: white;
            color: var(--primary-color);
            border: 2px solid white;
            padding: 0.5rem 1.5rem;
            border-radius: 30px;
            transition: var(--transition);
            text-decoration: none;
            font-weight: 600;
        }
        
        .btn-register:hover {
            background: transparent;
            color: white;
        }
        
        .user-dropdown {
            background: rgba(255,255,255,0.15);
            border-radius: 30px;
            padding: 0.5rem 1rem;
            color: white;
            text-decoration: none;
        }
        
        .user-dropdown:hover {
            background: rgba(255,255,255,0.25);
            color: white;
        }
        
        .dropdown-menu {
            border-radius: 12px;
            border: none;
            box-shadow: var(--box-shadow);
        }
        
        /* ========== LECTURE HERO ========== */
        .lecture-hero {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: white;
            padding: 3rem 0;
            margin-bottom: 3rem;
            border-radius: 0 0 40px 40px;
            box-shadow: 0 10px 30px rgba(52, 152, 219, 0.3);
        }
        
        .breadcrumb-custom {
            background: rgba(255,255,255,0.15);
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            display: inline-block;
            margin-bottom: 2rem;
        }
        
        .breadcrumb-custom a {
            color: white;
            text-decoration: none;
            opacity: 0.8;
            transition: var(--transition);
        }
        
        .breadcrumb-custom a:hover {
            opacity: 1;
        }
        
        .breadcrumb-custom span {
            color: white;
            font-weight: 600;
        }
        
        .lecture-title {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }
        
        .lecture-meta {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
            margin-top: 1.5rem;
        }
        
        .lecture-meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(255,255,255,0.15);
            padding: 0.5rem 1.2rem;
            border-radius: 30px;
            font-size: 0.95rem;
        }
        
        .lecture-meta-item i {
            font-size: 1.2rem;
        }
        
        .edit-mode-toggle {
            background: rgba(255,255,255,0.2);
            border: 2px solid rgba(255,255,255,0.3);
            color: white;
            padding: 0.8rem 1.8rem;
            border-radius: 40px;
            font-size: 1rem;
            font-weight: 600;
            transition: var(--transition);
            cursor: pointer;
        }
        
        .edit-mode-toggle:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-3px);
        }
        
        .edit-mode-toggle.active {
            background: white;
            color: var(--primary-color);
            border-color: white;
        }
        
        /* ========== MATERIAL CARDS ========== */
        .section-card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--box-shadow);
            margin-bottom: 2rem;
            overflow: hidden;
        }
        
        .section-header {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid #e9ecef;
            background: white;
        }
        
        .section-header h3 {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary-color);
        }
        
        .section-header h3 i {
            margin-right: 0.8rem;
            color: var(--secondary-color);
        }
        
        .section-body {
            padding: 2rem;
        }
        
        .material-card {
            background: var(--light-bg);
            border-radius: 16px;
            padding: 1.2rem;
            margin-bottom: 1rem;
            border-left: 5px solid var(--secondary-color);
            transition: var(--transition);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .material-card:hover {
            transform: translateX(8px);
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.15);
            background: white;
        }
        
        .material-info {
            display: flex;
            align-items: center;
            gap: 1.2rem;
        }
        
        .material-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
        }
        
        .material-icon.pdf { background: #fee9e7; color: #e74c3c; }
        .material-icon.zip { background: #fef5e7; color: #f39c12; }
        .material-icon.java { background: #e3f0ff; color: #3498db; }
        .material-icon.default { background: #e8f5e9; color: #27ae60; }
        
        .material-details h5 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.3rem;
        }
        
        .material-details small {
            color: #6c757d;
            display: flex;
            gap: 1rem;
        }
        
        .material-actions {
            display: flex;
            gap: 0.5rem;
        }
        
        .btn-download {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: white;
            border: 1px solid #dee2e6;
            color: var(--secondary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
        }
        
        .btn-download:hover {
            background: var(--secondary-color);
            color: white;
            border-color: var(--secondary-color);
        }
        
        .btn-delete-material {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: white;
            border: 1px solid #dee2e6;
            color: var(--accent-color);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
        }
        
        .btn-delete-material:hover {
            background: var(--accent-color);
            color: white;
            border-color: var(--accent-color);
        }
        
        /* ========== SUMMARY SECTION ========== */
        .summary-content {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #495057;
        }
        
        .topic-tag {
            background: var(--light-bg);
            padding: 0.5rem 1.2rem;
            border-radius: 30px;
            margin: 0.3rem;
            display: inline-block;
            border: 1px solid #e9ecef;
        }
        
        .topic-tag i {
            color: var(--success-color);
            margin-right: 0.3rem;
        }
        
        /* ========== COMMENTS SECTION ========== */
        .comments-section {
            background: var(--light-bg);
            border-radius: 20px;
            padding: 2rem;
            margin-top: 2rem;
        }
        
        .comment-form {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.03);
        }
        
        .comment-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border: 1px solid #e9ecef;
            transition: var(--transition);
        }
        
        .comment-card:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .comment-card.teacher-comment {
            border-left: 5px solid var(--accent-color);
            background: #fef5f4;
        }
        
        .comment-avatar {
            width: 55px;
            height: 55px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.3rem;
        }
        
        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.8rem;
        }
        
        .comment-author {
            font-weight: 600;
            font-size: 1.1rem;
        }
        
        .teacher-badge {
            background: var(--accent-color);
            color: white;
            padding: 0.2rem 0.8rem;
            border-radius: 30px;
            font-size: 0.7rem;
            font-weight: 600;
            margin-left: 0.8rem;
            text-transform: uppercase;
        }
        
        .you-badge {
            background: var(--secondary-color);
            color: white;
            padding: 0.2rem 0.8rem;
            border-radius: 30px;
            font-size: 0.7rem;
            font-weight: 600;
            margin-left: 0.8rem;
        }
        
        .comment-time {
            color: #6c757d;
            font-size: 0.85rem;
        }
        
        .comment-content {
            margin: 1rem 0;
            line-height: 1.7;
        }
        
        .comment-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #e9ecef;
        }
        
        .btn-comment-action {
            background: none;
            border: none;
            color: #6c757d;
            font-size: 0.9rem;
            padding: 0.3rem 1rem;
            border-radius: 20px;
            transition: var(--transition);
        }
        
        .btn-comment-action:hover {
            background: #e9ecef;
            color: var(--primary-color);
        }
        
        .btn-comment-action i {
            margin-right: 0.3rem;
        }
        
        /* ========== SIDEBAR ========== */
        .sidebar-card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--box-shadow);
            margin-bottom: 1.5rem;
            overflow: hidden;
        }
        
        .sidebar-header {
            padding: 1.2rem 1.5rem;
            border-bottom: 1px solid #e9ecef;
            font-weight: 600;
            color: var(--primary-color);
        }
        
        .sidebar-body {
            padding: 1.5rem;
        }
        
        .instructor-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, #3498db, #2c3e50);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            font-weight: bold;
            margin: 0 auto 1rem;
        }
        
        .related-lecture-item {
            padding: 1rem;
            border-bottom: 1px solid #e9ecef;
            transition: var(--transition);
            display: block;
            text-decoration: none;
            color: inherit;
        }
        
        .related-lecture-item:hover {
            background: var(--light-bg);
        }
        
        .quick-action-btn {
            display: block;
            width: 100%;
            text-align: left;
            padding: 1rem;
            border-radius: 12px;
            border: 1px solid #e9ecef;
            background: white;
            margin-bottom: 0.8rem;
            transition: var(--transition);
            color: inherit;
            text-decoration: none;
        }
        
        .quick-action-btn:hover {
            background: var(--light-bg);
            border-color: var(--secondary-color);
            transform: translateX(5px);
        }
        
        /* ========== BATCH UPLOAD ========== */
        .batch-upload-area {
            border: 3px dashed var(--secondary-color);
            border-radius: 20px;
            padding: 2.5rem;
            text-align: center;
            background: #e3f0ff;
            cursor: pointer;
            transition: var(--transition);
            margin: 1rem 0;
        }
        
        .batch-upload-area:hover {
            background: #d1e6ff;
            transform: scale(1.02);
        }
        
        .batch-upload-area i {
            font-size: 4rem;
            color: var(--secondary-color);
            margin-bottom: 1rem;
        }
        
        /* ========== EMPTY STATES ========== */
        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            background: var(--light-bg);
            border-radius: 16px;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #adb5bd;
            margin-bottom: 1rem;
            opacity: 0.4;
        }
        
        /* ========== FOOTER ========== */
        .custom-footer {
            background: var(--primary-color);
            color: white;
            padding: 3rem 0 1.5rem;
            margin-top: 4rem;
        }
        
        .footer-link {
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            transition: var(--transition);
            line-height: 2;
        }
        
        .footer-link:hover {
            color: white;
            padding-left: 5px;
        }
        
        /* ========== RESPONSIVE ========== */
        @media (max-width: 768px) {
            .lecture-title {
                font-size: 2rem;
            }
            
            .lecture-meta {
                gap: 1rem;
            }
            
            .section-header {
                padding: 1rem 1.2rem;
            }
            
            .section-body {
                padding: 1.2rem;
            }
            
            .material-card {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .material-actions {
                width: 100%;
                justify-content: flex-end;
            }
            
            .breadcrumb-custom {
                font-size: 0.9rem;
                padding: 0.6rem 1rem;
            }
        }
    </style>
</head>
<body>

<!-- ========== CUSTOM NAVIGATION ========== -->
<nav class="custom-navbar">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <!-- Logo -->
            <a href="/" class="navbar-brand text-decoration-none">
                <i class="bi bi-mortarboard-fill me-2"></i>
                EduPortal
            </a>
            
            <!-- Navigation Links (Hidden on mobile) -->
            <div class="d-none d-lg-flex gap-4">
                <a href="/lectures" class="nav-link text-decoration-none">Lectures</a>
                <a href="/polls" class="nav-link text-decoration-none">Polls</a>
                <a href="/about" class="nav-link text-decoration-none">About</a>
            </div>
            
            <!-- Right Side Menu -->
            <div class="d-flex align-items-center gap-3">
                <!-- Language Switcher -->
                <div class="dropdown">
                    <button class="language-btn dropdown-toggle" type="button" data-bs-toggle="dropdown">
                        <i class="bi bi-translate me-1"></i>
                        <span th:text="${lang == 'zh' ? '中' : 'EN'}">EN</span>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="?lang=en">🇬🇧 English</a></li>
                        <li><a class="dropdown-item" href="?lang=zh">🇭🇰 繁體中文</a></li>
                    </ul>
                </div>
                
                <!-- User Menu (Dynamic based on login status) -->
                <div th:if="${session.user == null}">
                    <a href="/login" class="btn-login text-decoration-none me-2">Login</a>
                    <a href="/register" class="btn-register text-decoration-none">Register</a>
                </div>
                
                <div th:if="${session.user != null}" class="dropdown">
                    <a href="#" class="user-dropdown text-decoration-none dropdown-toggle" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle me-2"></i>
                        <span th:text="${session.user.fullName}">John Doe</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="/profile"><i class="bi bi-person me-2"></i>Profile</a></li>
                        <li><a class="dropdown-item" href="/voting-history"><i class="bi bi-check-circle me-2"></i>Voting History</a></li>
                        <li><a class="dropdown-item" href="/comment-history"><i class="bi bi-chat me-2"></i>Comment History</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="/logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- ========== LECTURE HERO SECTION ========== -->
<section class="lecture-hero">
    <div class="container">
        <!-- Breadcrumb -->
        <div class="breadcrumb-custom">
            <a href="/" class="text-decoration-none">Home</a>
            <i class="bi bi-chevron-right mx-2"></i>
            <a href="/lectures" class="text-decoration-none">Lectures</a>
            <i class="bi bi-chevron-right mx-2"></i>
            <span th:text="${lecture.title}">Current Lecture</span>
        </div>
        
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1 class="lecture-title" th:text="${lecture.title}">Spring Boot Fundamentals</h1>
                <p class="lead mb-4" th:text="${lecture.description}">
                    Learn the core concepts of Spring Boot and build your first web application.
                </p>
                
                <!-- Lecture Meta Information -->
                <div class="lecture-meta">
                    <span class="lecture-meta-item">
                        <i class="bi bi-calendar3"></i>
                        <span th:text="${#dates.format(lecture.createdAt, 'dd MMM yyyy')}">15 Mar 2026</span>
                    </span>
                    <span class="lecture-meta-item">
                        <i class="bi bi-files"></i>
                        <span th:text="${lecture.materials != null ? lecture.materials.size() : 0} + ' materials'">5 materials</span>
                    </span>
                    <span class="lecture-meta-item">
                        <i class="bi bi-chat"></i>
                        <span th:text="${lecture.comments != null ? lecture.comments.size() : 0} + ' comments'">12 comments</span>
                    </span>
                    <span class="lecture-meta-item">
                        <i class="bi bi-person-circle"></i>
                        <span th:text="${lecture.instructorName}">Dr. Chen</span>
                    </span>
                </div>
            </div>
            
            <!-- Teacher Edit Mode Toggle -->
            <div class="col-lg-4 text-lg-end mt-4 mt-lg-0" 
                 th:if="${session.user != null and session.user.role == 'TEACHER'}">
                <button class="edit-mode-toggle" id="toggleEditMode" onclick="toggleEditMode()">
                    <i class="bi bi-pencil-square me-2"></i>
                    <span id="editModeText">Enable Edit Mode</span>
                </button>
            </div>
        </div>
    </div>
</section>

<!-- ========== MAIN CONTENT ========== -->
<div class="container mb-5">
    <div class="row">
        <!-- Left Column (Main Content) -->
        <div class="col-lg-8">
            
            <!-- MATERIALS SECTION -->
            <div class="section-card">
                <div class="section-header d-flex justify-content-between align-items-center">
                    <h3>
                        <i class="bi bi-files"></i>
                        Lecture Materials
                    </h3>
                    
                    <!-- Teacher Controls -->
                    <div th:if="${session.user != null and session.user.role == 'TEACHER'}" 
                         class="teacher-edit-controls" style="display: none;">
                        <button class="btn btn-primary btn-sm me-2" onclick="showAddMaterialModal()">
                            <i class="bi bi-plus-lg"></i> Add
                        </button>
                        <button class="btn btn-success btn-sm" onclick="showBatchUploadModal()">
                            <i class="bi bi-cloud-upload"></i> Batch
                        </button>
                    </div>
                </div>
                
                <div class="section-body">
                    <!-- Materials List -->
                    <div th:if="${lecture.materials != null and not #lists.isEmpty(lecture.materials)}">
                        <div th:each="material : ${lecture.materials}" class="material-card">
                            <div class="material-info">
                                <!-- Dynamic Icon based on file type -->
                                <div th:class="${'material-icon ' + 
                                    (material.fileName.endsWith('.pdf') ? 'pdf' : 
                                     material.fileName.endsWith('.zip') ? 'zip' : 
                                     material.fileName.endsWith('.java') ? 'java' : 'default')}">
                                    <i th:class="${'bi ' + 
                                        (material.fileName.endsWith('.pdf') ? 'bi-file-earmark-pdf' : 
                                         material.fileName.endsWith('.zip') ? 'bi-file-earmark-zip' : 
                                         material.fileName.endsWith('.java') ? 'bi-file-earmark-code' : 
                                         'bi-file-earmark')}"></i>
                                </div>
                                
                                <div class="material-details">
                                    <h5 th:text="${material.fileName}">lecture_notes.pdf</h5>
                                    <small>
                                        <span th:text="${#numbers.formatDecimal(material.fileSize/1024, 1, 2) + ' KB'}">1.2 MB</span>
                                        <span class="mx-2">•</span>
                                        <span th:text="${#dates.format(material.uploadDate, 'dd MMM yyyy')}">20 Mar 2026</span>
                                    </small>
                                </div>
                            </div>
                            
                            <div class="material-actions">
                                <a th:href="@{/materials/download/{id}(id=${material.id})}" 
                                   class="btn-download">
                                    <i class="bi bi-download"></i>
                                </a>
                                
                                <button th:if="${session.user != null and session.user.role == 'TEACHER'}"
                                        class="btn-delete-material teacher-edit-controls" 
                                        style="display: none;"
                                        th:onclick="'deleteMaterial(' + ${material.id} + ')'">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Empty State -->
                    <div th:if="${lecture.materials == null or #lists.isEmpty(lecture.materials)}" class="empty-state">
                        <i class="bi bi-files"></i>
                        <h5>No Materials Yet</h5>
                        <p class="text-muted">Check back later for lecture notes and resources.</p>
                        
                        <div th:if="${session.user != null and session.user.role == 'TEACHER'}"
                             class="teacher-edit-controls mt-3" style="display: none;">
                            <button class="btn btn-primary" onclick="showBatchUploadModal()">
                                <i class="bi bi-cloud-upload me-2"></i>Upload Materials
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- SUMMARY SECTION -->
            <div class="section-card">
                <div class="section-header">
                    <h3>
                        <i class="bi bi-card-text"></i>
                        Lecture Summary
                    </h3>
                </div>
                
                <div class="section-body">
                    <div class="summary-content" th:text="${lecture.detailedSummary}">
                        This lecture covers the fundamentals of Spring Boot including dependency injection, 
                        auto-configuration, and building REST APIs. We'll also explore Spring Data JPA for 
                        database integration and Thymeleaf for server-side rendering.
                    </div>
                    
                    <!-- Key Topics -->
                    <h6 class="mt-4 mb-3 fw-bold">Key Topics Covered:</h6>
                    <div>
                        <span th:each="topic : ${lecture.topics}" class="topic-tag">
                            <i class="bi bi-check-circle-fill"></i>
                            <span th:text="${topic}">Dependency Injection</span>
                        </span>
                    </div>
                </div>
            </div>
            
            <!-- COMMENTS SECTION -->
            <div class="comments-section" id="comments">
                <h4 class="mb-4">
                    <i class="bi bi-chat-dots me-2" style="color: var(--secondary-color);"></i>
                    Discussion 
                    <span class="badge bg-secondary" th:text="${lecture.comments != null ? lecture.comments.size() : 0}">12</span>
                </h4>
                
                <!-- Comment Form (Registered Users Only) -->
                <div th:if="${session.user != null}" class="comment-form">
                    <form th:action="@{/lecture/{id}/comment(id=${lecture.id})}" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold mb-2">
                                <i class="bi bi-pencil me-1"></i>Write a comment
                            </label>
                            <textarea class="form-control" name="content" rows="3" 
                                      placeholder="Share your thoughts about this lecture..." 
                                      required style="border-radius: 12px;"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary px-4 py-2" 
                                style="border-radius: 30px;">
                            <i class="bi bi-send me-2"></i>Post Comment
                        </button>
                    </form>
                </div>
                
                <!-- Login Prompt for Guests -->
                <div th:if="${session.user == null}" class="alert alert-info mb-4" 
                     style="border-radius: 16px;">
                    <i class="bi bi-info-circle me-2"></i>
                    <a href="/login" class="alert-link fw-bold">Login</a> to join the discussion and share your thoughts.
                </div>
                
                <!-- Comments List -->
                <div th:if="${lecture.comments != null and not #lists.isEmpty(lecture.comments)}">
                    <div th:each="comment : ${lecture.comments}" class="comment-card" 
                         th:classappend="${comment.userRole == 'TEACHER' ? 'teacher-comment' : ''}">
                        
                        <div class="d-flex gap-3">
                            <!-- Avatar -->
                            <div class="comment-avatar">
                                <span th:text="${#strings.substring(comment.userFullName, 0, 1)}">C</span>
                            </div>
                            
                            <div style="flex: 1;">
                                <!-- Comment Header -->
                                <div class="comment-header">
                                    <div>
                                        <span class="comment-author" th:text="${comment.userFullName}">Chan Tai Man</span>
                                        <span th:if="${comment.userRole == 'TEACHER'}" class="teacher-badge">Teacher</span>
                                        <span th:if="${comment.userId == session.user?.id}" class="you-badge">You</span>
                                    </div>
                                    <span class="comment-time" th:text="${#dates.format(comment.createdAt, 'dd MMM yyyy HH:mm')}">
                                        21 Mar 2026 14:30
                                    </span>
                                </div>
                                
                                <!-- Comment Content -->
                                <div class="comment-content" th:text="${comment.content}">
                                    This is a great lecture! The examples were very helpful.
                                </div>
                                
                                <!-- Comment Actions -->
                                <div class="comment-actions">
                                    <!-- Teacher Delete (Edit Mode) -->
                                    <button th:if="${session.user != null and session.user.role == 'TEACHER'}"
                                            class="btn-comment-action teacher-edit-controls" 
                                            style="display: none;"
                                            th:onclick="'deleteComment(' + ${comment.id} + ')'">
                                        <i class="bi bi-trash"></i> Delete (Teacher)
                                    </button>
                                    
                                    <!-- Own Comment Actions -->
                                    <div th:if="${session.user != null and session.user.id == comment.userId}">
                                        <button class="btn-comment-action" 
                                                th:onclick="'editComment(' + ${comment.id} + ')'">
                                            <i class="bi bi-pencil"></i> Edit
                                        </button>
                                        <button class="btn-comment-action text-danger" 
                                                th:onclick="'deleteOwnComment(' + ${comment.id} + ')'">
                                            <i class="bi bi-trash"></i> Delete
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Empty Comments State -->
                <div th:if="${lecture.comments == null or #lists.isEmpty(lecture.comments)}" class="empty-state">
                    <i class="bi bi-chat-dots"></i>
                    <h5 class="mt-3">No Comments Yet</h5>
                    <p class="text-muted">Be the first to share your thoughts about this lecture!</p>
                </div>
                
                <!-- Load More Button -->
                <div th:if="${lecture.hasMoreComments}" class="text-center mt-4">
                    <button class="btn btn-outline-primary px-5 py-2" 
                            style="border-radius: 30px;"
                            onclick="loadMoreComments()">
                        <i class="bi bi-arrow-down me-2"></i>Load More
                    </button>
                </div>
            </div>
        </div>
        
        <!-- ========== RIGHT SIDEBAR ========== -->
        <div class="col-lg-4">
            <!-- Instructor Card -->
            <div class="sidebar-card">
                <div class="sidebar-header">
                    <i class="bi bi-person-badge me-2"></i>
                    Instructor
                </div>
                <div class="sidebar-body text-center">
                    <div class="instructor-avatar mx-auto">
                        <span th:text="${#strings.substring(lecture.instructorName, 0, 1)}">C</span>
                    </div>
                    <h5 class="mt-3" th:text="${lecture.instructorName}">Dr. Chen Wei</h5>
                    <p class="text-muted small">Course Instructor</p>
                    <p class="small mt-3" th:text="${lecture.instructorBio}">
                        PhD in Computer Science with 10+ years experience in enterprise software development.
                    </p>
                    <span class="badge bg-primary px-3 py-2" style="border-radius: 30px;">
                        <i class="bi bi-star-fill me-1"></i>Teacher
                    </span>
                </div>
            </div>
            
            <!--