<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top" style="background-color: #000000 !important; box-shadow: 0 2px 10px rgba(0,0,0,0.3);">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="bi bi-mortarboard-fill me-2"></i>EduPortal
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <!-- 語言切換 -->
                <li class="nav-item dropdown me-3">
                    <a class="nav-link dropdown-toggle language-btn" href="#" role="button" data-bs-toggle="dropdown" style="background: rgba(255,255,255,0.15); border: 1px solid rgba(255,255,255,0.2);">
                        <i class="bi bi-translate me-1"></i>
                        <c:choose>
                            <c:when test="${sessionScope.lang == 'zh'}">中</c:when>
                            <c:otherwise>EN</c:otherwise>
                        </c:choose>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="javascript:changeLanguage('en')">🇬🇧 English</a></li>
                        <li><a class="dropdown-item" href="javascript:changeLanguage('zh')">🇭🇰 繁體中文</a></li>
                    </ul>
                </li>
                
                <!-- 教師專屬：創建課程按鈕 -->
                <c:if test="${sessionScope.role == 'TEACHER'}">
                    <li class="nav-item me-2">
                        <a href="/lecture/create" class="btn btn-success btn-sm">
                            <i class="bi bi-plus-circle me-1"></i> Create Lecture
                        </a>
                    </li>
                    <!-- 教師專屬：創建投票按鈕 -->
                    <li class="nav-item me-2">
                        <a href="/poll/create" class="btn btn-warning btn-sm">
                            <i class="bi bi-bar-chart me-1"></i> Create Poll
                        </a>
                    </li>
                </c:if>
                
                <!-- 用戶菜單 -->
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <li class="nav-item">
                            <a class="btn btn-outline-light me-2" href="${pageContext.request.contextPath}/login" style="border-color: rgba(255,255,255,0.5);">
                                <i class="bi bi-box-arrow-in-right me-1"></i>Login
                            </a>
                            <a class="btn btn-light" href="${pageContext.request.contextPath}/register" style="background: white; color: #000;">
                                <i class="bi bi-person-plus me-1"></i>Register
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" style="color: white;">
                                <i class="bi bi-person-circle me-1"></i>
                                <c:choose>
                                    <c:when test="${not empty sessionScope.userFullName}">
                                        <c:out value="${sessionScope.userFullName}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:out value="${sessionScope.user}"/>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="bi bi-person me-2"></i>Profile</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/voting-history"><i class="bi bi-check-circle me-2"></i>Voting History</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/comment-history"><i class="bi bi-chat me-2"></i>Comment History</a></li>
                                <c:if test="${sessionScope.role == 'TEACHER'}">
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-success" href="/lecture/create"><i class="bi bi-plus-circle me-2"></i>Create Lecture</a></li>
                                    <li><a class="dropdown-item text-warning" href="/poll/create"><i class="bi bi-bar-chart me-2"></i>Create Poll</a></li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                            </ul>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<style>
    .language-btn {
        background: rgba(255,255,255,0.15);
        border: 1px solid rgba(255,255,255,0.2);
        color: white;
        padding: 0.5rem 1rem;
        border-radius: 20px;
        transition: all 0.3s ease;
    }
    .language-btn:hover {
        background: rgba(255,255,255,0.3);
        transform: translateY(-2px);
        color: white;
    }
    .navbar-nav .nav-link {
        color: white;
    }
    .navbar-nav .nav-link:hover {
        color: rgba(255,255,255,0.8);
    }
    .navbar-brand {
        font-weight: 600;
        font-size: 1.3rem;
    }
</style>

<script>
    function changeLanguage(lang) {
        var url = new URL(window.location.href);
        url.searchParams.set('lang', lang);
        window.location.href = url.toString();
    }
</script>
