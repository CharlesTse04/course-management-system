<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'en'}" />
<fmt:setBundle basename="i18n/messages" />

<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'en'}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key="voting.history.title" /> - <fmt:message key="app.name" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { background-color: #f5f5f5; }
        .page-header { background: linear-gradient(135deg, #2c3e50, #3498db); color: white; padding: 2rem 0; margin-bottom: 2rem; }
        .stat-card { background: white; border-radius: 15px; padding: 1rem; text-align: center; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .vote-card { background: white; border-radius: 12px; padding: 1rem; margin-bottom: 1rem; border-left: 4px solid #3498db; }
        .option-badge { background: #e3f0ff; color: #3498db; padding: 0.2rem 0.8rem; border-radius: 20px; font-size: 0.8rem; }
        .status-current { background: #d4edda; color: #155724; padding: 0.2rem 0.8rem; border-radius: 20px; font-size: 0.8rem; display: inline-block; }
        .status-changed { background: #fff3cd; color: #856404; padding: 0.2rem 0.8rem; border-radius: 20px; font-size: 0.8rem; display: inline-block; }
        .empty-state { text-align: center; padding: 3rem; background: white; border-radius: 15px; }
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
            <i class="bi bi-arrow-left"></i> <fmt:message key="voting.history.back" />
        </a>
        <h1 class="mt-3"><i class="bi bi-check-circle-fill me-2"></i> <fmt:message key="voting.history.title" /></h1>
        <p class="mb-0"><fmt:message key="voting.history.subtitle" /></p>
    </div>
</div>

<div class="container mb-5">
    <!-- Stats -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="stat-card">
                <i class="bi bi-bar-chart fs-1 text-primary"></i>
                <h2 class="mt-2">${totalVotes}</h2>
                <p><fmt:message key="voting.history.total.votes" /></p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <i class="bi bi-trophy fs-1 text-success"></i>
                <h2 class="mt-2">${participationRate}%</h2>
                <p><fmt:message key="voting.history.participation" /></p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <i class="bi bi-calendar-check fs-1 text-warning"></i>
                <h2 class="mt-2">${activePolls}</h2>
                <p><fmt:message key="voting.history.active.polls" /></p>
            </div>
        </div>
    </div>
    
    <!-- Voting History List -->
    <c:choose>
        <c:when test="${not empty votingHistory}">
            <c:forEach var="vote" items="${votingHistory}">
                <div class="vote-card">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="mb-1"><c:out value="${vote.pollQuestion}"/></h5>
                            <span class="option-badge"><i class="bi bi-check-circle me-1"></i> <c:out value="${vote.selectedOption}"/></span>
                            <small class="text-muted ms-2">
                                ${vote.formattedVotedAt}
                            </small>
                        </div>
                        <div>
                            <c:choose>
                                <c:when test="${vote.current}">
                                    <span class="status-current"><i class="bi bi-check-circle me-1"></i> <fmt:message key="voting.history.current" /></span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-changed"><i class="bi bi-arrow-repeat me-1"></i> <fmt:message key="voting.history.changed" /></span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="mt-2">
                        <a href="/poll?id=${vote.pollId}" class="btn btn-sm btn-outline-primary">
                            <i class="bi bi-eye me-1"></i> <fmt:message key="voting.history.view.poll" />
                        </a>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="bi bi-bar-chart-steps fs-1 text-muted"></i>
                <h3 class="mt-3"><fmt:message key="voting.history.empty.title" /></h3>
                <p><fmt:message key="voting.history.empty.message" /></p>
                <a href="/polls" class="btn btn-primary"><fmt:message key="voting.history.explore" /></a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
