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
    <title><fmt:message key="comment.history.title" /> - <fmt:message key="app.name" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { background-color: #f5f5f5; }
        .page-header { background: linear-gradient(135deg, #27ae60, #229954); color: white; padding: 2rem 0; margin-bottom: 2rem; }
        .stat-card { background: white; border-radius: 15px; padding: 1rem; text-align: center; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .comment-card { background: white; border-radius: 12px; padding: 1.2rem; margin-bottom: 1rem; border-left: 4px solid #3498db; }
        .source-badge { display: inline-block; padding: 0.2rem 0.8rem; border-radius: 20px; font-size: 0.7rem; margin-right: 0.5rem; }
        .source-lecture { background: #e3f0ff; color: #3498db; }
        .source-poll { background: #fee9e7; color: #e74c3c; }
        .empty-state { text-align: center; padding: 3rem; background: white; border-radius: 15px; }
        .word-cloud-tag { display: inline-block; padding: 0.3rem 1rem; margin: 0.3rem; border-radius: 20px; background: #f8f9fa; transition: all 0.3s; }
        .word-cloud-tag:hover { transform: scale(1.1); background: #27ae60; color: white; }
        .btn-back { background: #6c757d; color: white; border: none; padding: 0.5rem 1.2rem; border-radius: 25px; text-decoration: none; display: inline-block; margin-bottom: 1rem; }
        .btn-back:hover { background: #5a6268; color: white; }
        .btn-back i { margin-right: 0.5rem; }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="page-header">
    <div class="container">
        <a href="/" class="btn-back">
            <i class="bi bi-arrow-left"></i> <fmt:message key="comment.history.back" />
        </a>
        <h1 class="mt-3"><i class="bi bi-chat-dots-fill me-2"></i> <fmt:message key="comment.history.title" /></h1>
        <p><fmt:message key="comment.history.subtitle" /></p>
    </div>
</div>

<div class="container mb-5">
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="stat-card">
                <i class="bi bi-chat fs-1 text-primary"></i>
                <h2>${totalComments}</h2>
                <p><fmt:message key="comment.history.total" /></p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <i class="bi bi-journal-bookmark fs-1 text-info"></i>
                <h2>${lectureComments}</h2>
                <p><fmt:message key="comment.history.lecture" /></p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <i class="bi bi-bar-chart fs-1 text-danger"></i>
                <h2>${pollComments}</h2>
                <p><fmt:message key="comment.history.poll" /></p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <i class="bi bi-calendar fs-1 text-warning"></i>
                <h2>${avgCommentsPerMonth}</h2>
                <p><fmt:message key="comment.history.avg" /></p>
            </div>
        </div>
    </div>
    
    <c:choose>
        <c:when test="${not empty commentHistory}">
            <c:forEach var="comment" items="${commentHistory}">
                <div class="comment-card">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <span class="source-badge ${comment.sourceType == 'LECTURE' ? 'source-lecture' : 'source-poll'}">
                                <i class="bi ${comment.sourceType == 'LECTURE' ? 'bi-journal-bookmark' : 'bi-bar-chart'} me-1"></i>
                                <c:choose>
                                    <c:when test="${comment.sourceType == 'LECTURE'}"><fmt:message key="comment.history.lecture" /></c:when>
                                    <c:otherwise><fmt:message key="comment.history.poll" /></c:otherwise>
                                </c:choose>
                            </span>
                            <small class="text-muted ms-2">
                                ${comment.formattedDate}
                                (${comment.timeAgo})
                            </small>
                        </div>
                        <a href="${comment.sourceUrl}" class="btn btn-sm btn-outline-primary">
                            <i class="bi bi-eye"></i> <fmt:message key="comment.history.view" />
                        </a>
                    </div>
                    <div class="mt-2 fw-bold">${comment.sourceTitle}</div>
                    <div class="mt-2">${comment.content}</div>
                </div>
            </c:forEach>
            
            <div class="alert alert-success mt-4">
                <i class="bi bi-graph-up-arrow me-2"></i>
                <strong><fmt:message key="comment.history.engagement" />:</strong> ${engagementLevel}
                <span class="ms-3">
                    <c:forEach begin="1" end="${engagementStars}">
                        <i class="bi bi-star-fill text-warning"></i>
                    </c:forEach>
                    <c:forEach begin="${engagementStars+1}" end="5">
                        <i class="bi bi-star text-warning"></i>
                    </c:forEach>
                </span>
            </div>
            
            <div class="text-center mt-4 p-3 bg-white rounded">
                <h5><i class="bi bi-cloud me-2"></i> <fmt:message key="comment.history.wordcloud" /></h5>
                <div>
                    <c:forEach var="word" items="${wordCloud}">
                        <span class="word-cloud-tag" style="font-size: ${word.size}px;">
                            ${word.text}
                        </span>
                    </c:forEach>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="bi bi-chat-dots fs-1 text-muted"></i>
                <h3><fmt:message key="comment.history.empty.title" /></h3>
                <p><fmt:message key="comment.history.empty.message" /></p>
                <a href="/lectures" class="btn btn-primary"><fmt:message key="comment.history.browse" /></a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
