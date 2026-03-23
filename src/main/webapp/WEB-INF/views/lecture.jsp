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
    <title><c:out value="${lecture.title}"/> - <fmt:message key="app.name" /></title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --light-bg: #f8f9fa;
        }
        body { background-color: #f5f5f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .lecture-header { background: linear-gradient(135deg, #2c3e50, #3498db); color: white; padding: 3rem 0; margin-bottom: 2rem; }
        .lecture-title { font-size: 2.5rem; font-weight: 700; margin-bottom: 1rem; }
        .section-card { background: white; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 2rem; overflow: hidden; }
        .section-header { padding: 1.2rem 1.5rem; border-bottom: 1px solid #e9ecef; font-weight: 600; font-size: 1.2rem; background: white; }
        .section-body { padding: 1.5rem; }
        .material-item { display: flex; justify-content: space-between; align-items: center; padding: 1rem; border-bottom: 1px solid #e9ecef; }
        .material-item:last-child { border-bottom: none; }
        .comment-card { background: #f8f9fa; border-radius: 12px; padding: 1rem; margin-bottom: 1rem; }
        .comment-author { font-weight: 600; color: #2c3e50; }
        .comment-time { font-size: 0.8rem; color: #6c757d; }
        .teacher-badge { background: #e74c3c; color: white; padding: 0.2rem 0.6rem; border-radius: 20px; font-size: 0.7rem; margin-left: 0.5rem; }
        .you-badge { background: #3498db; color: white; padding: 0.2rem 0.6rem; border-radius: 20px; font-size: 0.7rem; margin-left: 0.5rem; }
        .btn-back { background: #6c757d; color: white; border: none; padding: 0.5rem 1.2rem; border-radius: 25px; text-decoration: none; display: inline-block; }
        .btn-back:hover { background: #5a6268; color: white; }
        .btn-download { background: #3498db; color: white; border: none; padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.8rem; text-decoration: none; }
        .btn-download:hover { background: #2980b9; color: white; }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="lecture-header">
    <div class="container">
        <a href="/" class="btn-back mb-3 d-inline-block">
            <i class="bi bi-arrow-left me-1"></i> <fmt:message key="lecture.back.home" />
        </a>
        <h1 class="lecture-title"><c:out value="${lecture.title}"/></h1>
        <p class="lead"><c:out value="${lecture.description}"/></p>
        <div class="mt-3">
            <span class="badge bg-light text-dark me-2">
                <i class="bi bi-calendar"></i> <c:out value="${formattedDate}"/>
            </span>
            <span class="badge bg-light text-dark me-2">
                <i class="bi bi-files"></i> <c:out value="${materialCount}"/> <fmt:message key="lecture.materials" />
            </span>
            <span class="badge bg-light text-dark">
                <i class="bi bi-chat"></i> <c:out value="${commentCount}"/> <fmt:message key="lecture.comments" />
            </span>
        </div>
    </div>
</div>

<div class="container mb-5">
    <div class="row">
        <div class="col-lg-8">
            <!-- Materials Section -->
            <div class="section-card">
                <div class="section-header">
                    <i class="bi bi-files me-2"></i> <fmt:message key="lecture.materials" />
                </div>
                <div class="section-body">
                    <c:choose>
                        <c:when test="${not empty materials}">
                            <c:forEach var="material" items="${materials}">
                                <div class="material-item">
                                    <div>
                                        <i class="bi bi-file-earmark-text me-2"></i>
                                        <strong><c:out value="${material.fileName}"/></strong>
                                        <br>
                                        <small class="text-muted">
                                            <c:out value="${material.fileSize / 1024}"/> KB
                                        </small>
                                    </div>
                                    <a href="/materials/download/${material.id}" class="btn-download">
                                        <i class="bi bi-download"></i> <fmt:message key="lecture.download" />
                                    </a>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted text-center"><fmt:message key="lecture.no.materials" /></p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <!-- Summary Section -->
            <div class="section-card">
                <div class="section-header">
                    <i class="bi bi-card-text me-2"></i> <fmt:message key="lecture.summary" />
                </div>
                <div class="section-body">
                    <p><c:out value="${lecture.detailedSummary != null ? lecture.detailedSummary : lecture.description}"/></p>
                </div>
            </div>
            
            <!-- Comments Section -->
            <div class="section-card">
                <div class="section-header">
                    <i class="bi bi-chat-dots me-2"></i> <fmt:message key="lecture.discussion" />
                </div>
                <div class="section-body">
                    <c:choose>
                        <c:when test="${isLoggedIn}">
                            <form action="/lecture/${lecture.id}/comment" method="post" class="mb-4">
                                <textarea name="content" class="form-control mb-2" rows="3" placeholder="<fmt:message key='lecture.comment.placeholder' />"></textarea>
                                <button type="submit" class="btn btn-primary"><fmt:message key="lecture.post.comment" /></button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">
                                <a href="/login" class="alert-link"><fmt:message key="lecture.login.to.comment" /></a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <c:choose>
                        <c:when test="${not empty comments}">
                            <c:forEach var="comment" items="${comments}">
                                <div class="comment-card">
                                    <div>
                                        <span class="comment-author"><c:out value="${comment.user.fullName}"/></span>
                                        <span class="comment-time"><c:out value="${comment.createdAt}"/></span>
                                        <c:if test="${comment.user.role == 'TEACHER'}">
                                            <span class="teacher-badge"><fmt:message key="lecture.teacher" /></span>
                                        </c:if>
                                        <c:if test="${comment.user.username == currentUser}">
                                            <span class="you-badge"><fmt:message key="lecture.you" /></span>
                                        </c:if>
                                    </div>
                                    <p class="mt-2 mb-0"><c:out value="${comment.content}"/></p>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted text-center"><fmt:message key="lecture.no.comments" /></p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        
        <div class="col-lg-4">
            <div class="section-card">
                <div class="section-header">
                    <i class="bi bi-person-badge me-2"></i> <fmt:message key="lecture.instructor" />
                </div>
                <div class="section-body text-center">
                    <div class="mb-3">
                        <i class="bi bi-person-circle" style="font-size: 4rem; color: #3498db;"></i>
                    </div>
                    <h5><c:out value="${lecture.instructorName != null ? lecture.instructorName : 'Course Instructor'}"/></h5>
                    <p class="small text-muted"><c:out value="${lecture.instructorBio != null ? lecture.instructorBio : 'Experienced instructor passionate about teaching.'}"/></p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
