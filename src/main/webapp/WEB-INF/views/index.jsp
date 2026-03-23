<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'en'}" />
<fmt:setBundle basename="i18n/messages" />

<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'en'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="app.name" /> - <fmt:message key="app.title" /></title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
        }
        body { 
            background-color: #f5f5f5; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        }
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4rem 0;
            margin-bottom: 3rem;
            border-radius: 0 0 50px 50px;
        }
        .course-title { font-size: 3rem; font-weight: 700; }
        .lecture-card, .poll-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            height: 100%;
            margin-bottom: 1.5rem;
        }
        .lecture-card:hover, .poll-card:hover { 
            transform: translateY(-10px); 
            box-shadow: 0 15px 30px rgba(0,0,0,0.15); 
        }
        .card-header {
            padding: 1.5rem;
            background: linear-gradient(135deg, var(--secondary-color), #2980b9);
            color: white;
        }
        .btn-view {
            background: linear-gradient(135deg, var(--secondary-color), #2980b9);
            color: white;
            border: none;
            padding: 0.6rem 1.5rem;
            border-radius: 25px;
            width: 100%;
            transition: all 0.3s ease;
        }
        .btn-view:hover { 
            transform: scale(1.05); 
            color: white; 
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }
        .login-prompt {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
            padding: 0.8rem 1.5rem;
            border-radius: 10px;
            margin: 2rem 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .stat-card {
            transition: all 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .section-header {
            position: relative;
            margin-bottom: 2rem;
            padding-bottom: 0.5rem;
        }
        .section-header:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--secondary-color), var(--accent-color));
            border-radius: 2px;
        }
        .guest-badge {
            background: rgba(255,255,255,0.2);
            padding: 0.5rem 1rem;
            border-radius: 30px;
            display: inline-block;
        }
        
        /* Teacher Controls Card */
        .teacher-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 20px;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        .teacher-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        .teacher-card .card-body {
            padding: 1.2rem 1.5rem;
        }
        .teacher-icon {
            font-size: 2rem;
            background: rgba(255,255,255,0.2);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
        }
        .teacher-title {
            font-weight: 600;
            font-size: 1.1rem;
        }
        .teacher-subtitle {
            font-size: 0.85rem;
            opacity: 0.9;
        }
        .teacher-btn {
            border-radius: 30px;
            padding: 0.5rem 1.2rem;
            font-weight: 500;
            transition: all 0.3s ease;
            margin-left: 0.5rem;
        }
        .teacher-btn-light {
            background: white;
            color: #667eea;
            border: none;
        }
        .teacher-btn-light:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255,255,255,0.3);
            color: #667eea;
        }
        .teacher-btn-outline {
            background: transparent;
            color: white;
            border: 1px solid rgba(255,255,255,0.5);
        }
        .teacher-btn-outline:hover {
            background: rgba(255,255,255,0.2);
            transform: translateY(-2px);
            color: white;
        }
        @media (max-width: 768px) {
            .teacher-card .card-body {
                flex-direction: column;
                text-align: center;
            }
            .teacher-icon {
                margin: 0 auto 1rem auto;
            }
            .teacher-buttons {
                margin-top: 1rem;
                justify-content: center;
            }
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<!-- Hero Section -->
<section class="hero-section">
    <div class="container text-center">
        <h1 class="course-title"><c:out value="${course.name}"/></h1>
        <p class="lead"><c:out value="${course.description}"/></p>
        <c:if test="${empty sessionScope.user}">
            <div class="mt-4">
                <div class="guest-badge">
                    <i class="bi bi-eye me-2"></i>
                    <fmt:message key="hero.guest.mode" />
                    <a href="${pageContext.request.contextPath}/login" class="text-white fw-bold"><fmt:message key="hero.login" /></a>
                </div>
            </div>
        </c:if>
    </div>
</section>

<div class="container mb-5">
    
    <!-- Teacher Quick Actions -->
    <c:if test="${sessionScope.role == 'TEACHER'}">
        <div class="teacher-card card">
            <div class="card-body d-flex justify-content-between align-items-center flex-wrap">
                <div class="d-flex align-items-center">
                    <div class="teacher-icon">
                        <i class="bi bi-gear-fill"></i>
                    </div>
                    <div>
                        <div class="teacher-title"><fmt:message key="teacher.controls.title" /></div>
                        <div class="teacher-subtitle"><fmt:message key="teacher.controls.subtitle" /></div>
                    </div>
                </div>
                <div class="d-flex teacher-buttons mt-2 mt-sm-0">
                    <a href="/lecture/create" class="btn teacher-btn teacher-btn-light">
                        <i class="bi bi-plus-circle me-2"></i><fmt:message key="teacher.create.lecture" />
                    </a>
                    <a href="/poll/create" class="btn teacher-btn teacher-btn-outline">
                        <i class="bi bi-bar-chart me-2"></i><fmt:message key="teacher.create.poll" />
                    </a>
                </div>
            </div>
        </div>
    </c:if>
    
    <!-- Lectures Section -->
    <section class="mb-5">
        <div class="section-header d-flex justify-content-between align-items-end">
            <h2><i class="bi bi-journal-bookmark-fill me-2" style="color: var(--secondary-color);"></i><fmt:message key="section.lectures" /></h2>
            <span class="text-muted"><fmt:message key="message.lectures.available"><fmt:param value="${fn:length(lectures)}" /></fmt:message></span>
        </div>
        
        <div class="row">
            <c:forEach var="lecture" items="${lectures}">
                <div class="col-md-6 col-lg-4">
                    <div class="lecture-card card">
                        <div class="card-header">
                            <i class="bi bi-file-earmark-text"></i>
                            <h5 class="mt-2"><c:out value="${lecture.title}"/></h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><c:out value="${lecture.description}"/></p>
                            <div class="lecture-meta text-muted small mb-2">
                                <span><i class="bi bi-files me-1"></i> <fmt:message key="material" /></span>
                                <span class="ms-3"><i class="bi bi-chat me-1"></i> <fmt:message key="comments" /></span>
                            </div>
                            <a href="${pageContext.request.contextPath}/lecture?id=${lecture.id}" class="btn btn-view mt-2">
                                <fmt:message key="button.view.lecture" /> <i class="bi bi-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/lectures" class="btn btn-outline-primary">
                <fmt:message key="button.view.all" /> <i class="bi bi-arrow-right"></i>
            </a>
        </div>
    </section>

    <!-- Polls Section -->
    <c:if test="${not empty polls}">
    <section class="mb-5">
        <div class="section-header d-flex justify-content-between align-items-end">
            <h2><i class="bi bi-bar-chart-fill me-2" style="color: var(--accent-color);"></i><fmt:message key="section.polls" /></h2>
            <span class="text-muted"><fmt:message key="message.polls.active"><fmt:param value="${fn:length(polls)}" /></fmt:message></span>
        </div>
        
        <div class="row">
            <c:forEach var="poll" items="${polls}">
                <div class="col-md-6">
                    <div class="poll-card card">
                        <div class="card-header" style="background: linear-gradient(135deg, #e74c3c, #c0392b);">
                            <i class="bi bi-question-circle"></i>
                            <h5 class="mt-2"><c:out value="${poll.question}"/></h5>
                        </div>
                        <div class="card-body">
                            <div class="text-center text-muted mb-3">
                                <i class="bi bi-people me-1"></i> <fmt:message key="message.total.votes" /> · 
                                <i class="bi bi-chat ms-2 me-1"></i> <fmt:message key="comments" />
                            </div>
                            <a href="${pageContext.request.contextPath}/poll?id=${poll.id}" class="btn btn-view mt-2" 
                               style="background: linear-gradient(135deg, #e74c3c, #c0392b);">
                                <fmt:message key="button.vote.now" /> <i class="bi bi-pencil ms-2"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/polls" class="btn btn-outline-danger">
                <fmt:message key="button.view.all" /> <i class="bi bi-arrow-right"></i>
            </a>
        </div>
    </section>
    </c:if>

    <!-- Login Prompt for Guests -->
    <c:if test="${empty sessionScope.user}">
        <div class="login-prompt">
            <div>
                <i class="bi bi-info-circle-fill me-2 fs-4"></i>
                <span class="fw-bold"><fmt:message key="prompt.want.to.participate" /></span> <fmt:message key="prompt.register.or.login" />
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-light me-2"><fmt:message key="nav.register" /></a>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light"><fmt:message key="nav.login" /></a>
            </div>
        </div>
    </c:if>

    <!-- Quick Stats Section -->
    <section class="row g-4 mt-4">
        <div class="col-md-3 col-6">
            <div class="card text-center p-3 stat-card">
                <i class="bi bi-journal-bookmark-fill fs-1" style="color: var(--secondary-color);"></i>
                <h3 class="mt-2"><c:out value="${totalLectures}"/></h3>
                <p class="text-muted mb-0"><fmt:message key="section.stats.lectures" /></p>
            </div>
        </div>
        <div class="col-md-3 col-6">
            <div class="card text-center p-3 stat-card">
                <i class="bi bi-bar-chart-fill fs-1" style="color: var(--accent-color);"></i>
                <h3 class="mt-2"><c:out value="${totalPolls}"/></h3>
                <p class="text-muted mb-0"><fmt:message key="section.stats.polls" /></p>
            </div>
        </div>
        <div class="col-md-3 col-6">
            <div class="card text-center p-3 stat-card">
                <i class="bi bi-people-fill fs-1" style="color: #27ae60;"></i>
                <h3 class="mt-2"><c:out value="${totalStudents}"/></h3>
                <p class="text-muted mb-0"><fmt:message key="section.stats.students" /></p>
            </div>
        </div>
        <div class="col-md-3 col-6">
            <div class="card text-center p-3 stat-card">
                <i class="bi bi-chat-fill fs-1" style="color: #f39c12;"></i>
                <h3 class="mt-2"><c:out value="${totalComments}"/></h3>
                <p class="text-muted mb-0"><fmt:message key="section.stats.comments" /></p>
            </div>
        </div>
    </section>
</div>

<jsp:include page="footer.jsp" />

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.lecture-card, .poll-card, .stat-card');
        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            setTimeout(() => {
                card.style.transition = 'all 0.5s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, 100 * index);
        });
    });
</script>

</body>
</html>
