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
    <title><fmt:message key="lectures.title" /> - <fmt:message key="app.name" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { 
            background: linear-gradient(135deg, #f5f7fa 0%, #e9ecef 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        }
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            color: white;
            padding: 4rem 0;
            margin-bottom: 3rem;
            border-radius: 0 0 40px 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .page-title {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            letter-spacing: -0.5px;
        }
        
        .page-subtitle {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        
        /* Back Button */
        .btn-back {
            background: rgba(255,255,255,0.2);
            color: white;
            border: none;
            padding: 0.6rem 1.5rem;
            border-radius: 30px;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }
        
        .btn-back:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-2px);
            color: white;
        }
        
        /* Lecture Card */
        .lecture-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            margin-bottom: 1.8rem;
            transition: all 0.3s ease;
            height: 100%;
            border: none;
        }
        
        .lecture-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.12);
        }
        
        .card-header {
            padding: 1.5rem;
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            border: none;
            position: relative;
            overflow: hidden;
        }
        
        .card-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 150px;
            height: 150px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
        }
        
        .card-header i {
            font-size: 2.2rem;
            margin-bottom: 0.8rem;
        }
        
        .card-header h5 {
            font-size: 1.2rem;
            font-weight: 600;
            margin: 0;
            line-height: 1.4;
        }
        
        .card-body {
            padding: 1.5rem;
        }
        
        .lecture-description {
            color: #6c757d;
            line-height: 1.6;
            margin-bottom: 1rem;
            font-size: 0.95rem;
        }
        
        .lecture-meta {
            display: flex;
            gap: 1rem;
            margin-top: 0.8rem;
            font-size: 0.85rem;
            color: #6c757d;
            padding: 0.8rem 0;
            border-top: 1px solid #e9ecef;
            border-bottom: 1px solid #e9ecef;
        }
        
        .lecture-meta span {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
        }
        
        .lecture-meta i {
            font-size: 0.9rem;
        }
        
        .btn-view {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            border: none;
            padding: 0.7rem 1rem;
            border-radius: 30px;
            text-decoration: none;
            display: inline-block;
            width: 100%;
            text-align: center;
            transition: all 0.3s ease;
            font-weight: 500;
            margin-top: 1rem;
        }
        
        .btn-view:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
            color: white;
        }
        
        /* Stats Badge */
        .stats-badge {
            background: #f8f9fa;
            padding: 0.5rem 1.2rem;
            border-radius: 40px;
            font-size: 0.9rem;
            color: #2c3e50;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 5rem 2rem;
            background: white;
            border-radius: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        
        .empty-state i {
            font-size: 5rem;
            color: #dee2e6;
            margin-bottom: 1.5rem;
        }
        
        .empty-state h3 {
            font-size: 1.8rem;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }
        
        .empty-state p {
            color: #6c757d;
            margin-bottom: 2rem;
        }
        
        /* Teacher Create Button */
        .teacher-create-card {
            background: linear-gradient(135deg, #27ae60, #229954);
            border-radius: 20px;
            padding: 1.2rem 1.8rem;
            margin-bottom: 2rem;
            transition: all 0.3s ease;
        }
        
        .teacher-create-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(39, 174, 96, 0.3);
        }
        
        .teacher-create-btn {
            background: white;
            color: #27ae60;
            border: none;
            padding: 0.6rem 1.5rem;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .teacher-create-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            color: #27ae60;
        }
        
        @media (max-width: 768px) {
            .page-title {
                font-size: 2rem;
            }
            .page-subtitle {
                font-size: 1rem;
            }
            .card-header h5 {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="page-header">
    <div class="container">
        <a href="/" class="btn-back">
            <i class="bi bi-arrow-left me-2"></i><fmt:message key="lectures.back.home" />
        </a>
        <h1 class="page-title">
            <i class="bi bi-journal-bookmark-fill me-3"></i>
            <fmt:message key="lectures.title" />
        </h1>
        <p class="page-subtitle"><fmt:message key="lectures.subtitle" /></p>
    </div>
</div>

<div class="container mb-5">
    <!-- Teacher Create Button -->
    <c:if test="${sessionScope.role == 'TEACHER'}">
        <div class="teacher-create-card d-flex justify-content-between align-items-center flex-wrap">
            <div class="text-white mb-2 mb-sm-0">
                <i class="bi bi-plus-circle-fill me-2"></i>
                <strong><fmt:message key="teacher.create.lecture.prompt" /></strong>
            </div>
            <a href="/lecture/create" class="teacher-create-btn">
                <i class="bi bi-plus-circle me-2"></i><fmt:message key="teacher.create.lecture" />
            </a>
        </div>
    </c:if>
    
    <c:choose>
        <c:when test="${not empty lectures}">
            <div class="row">
                <c:forEach var="lecture" items="${lectures}">
                    <div class="col-md-6 col-lg-4">
                        <div class="lecture-card">
                            <div class="card-header">
                                <i class="bi bi-file-earmark-text"></i>
                                <h5><c:out value="${lecture.title}"/></h5>
                            </div>
                            <div class="card-body">
                                <div class="lecture-description">
                                    <c:out value="${fn:substring(lecture.description, 0, 100)}"/>
                                    <c:if test="${fn:length(lecture.description) > 100}">...</c:if>
                                </div>
                                <div class="lecture-meta">
                                    <span><i class="bi bi-calendar3"></i> <c:out value="${lecture.formattedCreatedAt}"/></span>
                                    <span><i class="bi bi-chat"></i> <c:out value="${lecture.commentCount}"/> <fmt:message key="lectures.comments" /></span>
                                </div>
                                <a href="/lecture?id=${lecture.id}" class="btn-view">
                                    <fmt:message key="lectures.view" /> <i class="bi bi-arrow-right ms-2"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="text-center mt-4">
                <div class="stats-badge">
                    <i class="bi bi-journal-bookmark"></i>
                    <c:out value="${fn:length(lectures)}"/> <fmt:message key="lectures.total" />
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="bi bi-journal-bookmark"></i>
                <h3><fmt:message key="lectures.empty.title" /></h3>
                <p><fmt:message key="lectures.empty.message" /></p>
                <c:if test="${sessionScope.role == 'TEACHER'}">
                    <a href="/lecture/create" class="btn btn-success btn-lg px-4">
                        <i class="bi bi-plus-circle me-2"></i><fmt:message key="teacher.create.lecture" />
                    </a>
                </c:if>
                <c:if test="${sessionScope.role != 'TEACHER'}">
                    <a href="/" class="btn btn-primary btn-lg px-4">
                        <i class="bi bi-house-door me-2"></i><fmt:message key="lectures.back.home" />
                    </a>
                </c:if>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
