<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'en'}" />
<fmt:setBundle basename="i18n/messages" />

<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'en'}">
<head>
    <meta charset="UTF-8">
    <title><c:out value="${poll.question}"/> - <fmt:message key="poll.title" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
        body { background-color: #f5f5f5; }
        .poll-header { background: linear-gradient(135deg, #e74c3c, #c0392b); color: white; padding: 2rem 0; margin-bottom: 2rem; }
        .poll-card { background: white; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 2rem; overflow: hidden; }
        .poll-card-header { padding: 1.5rem; border-bottom: 1px solid #e9ecef; background: #fef5f4; }
        .poll-option { padding: 1rem; border-bottom: 1px solid #e9ecef; }
        .vote-progress { height: 8px; background: #e9ecef; border-radius: 10px; margin-top: 0.5rem; overflow: hidden; }
        .vote-progress-bar { height: 100%; background: linear-gradient(90deg, #e74c3c, #e67e22); border-radius: 10px; }
        .btn-vote { background: #e74c3c; color: white; border: none; padding: 0.8rem 2rem; border-radius: 30px; }
        .btn-vote:hover { background: #c0392b; }
        .btn-back { background: #6c757d; color: white; border: none; padding: 0.5rem 1.2rem; border-radius: 25px; text-decoration: none; display: inline-block; margin-bottom: 1rem; }
        .btn-back:hover { background: #5a6268; color: white; }
        .user-vote { background: #d4edda; padding: 1rem; border-radius: 10px; margin-bottom: 1rem; }
        .comment-card { background: white; border-radius: 12px; padding: 1rem; margin-bottom: 1rem; border: 1px solid #e9ecef; }
        .stat-item { display: flex; justify-content: space-between; padding: 0.8rem 0; border-bottom: 1px solid #e9ecef; }
        .chart-container { background: white; border-radius: 15px; padding: 1.5rem; margin: 1.5rem 0; }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="poll-header">
    <div class="container">
        <a href="/" class="btn-back">
            <i class="bi bi-arrow-left me-1"></i> <fmt:message key="poll.back.home" />
        </a>
        <nav class="mb-3">
            <a href="/polls" class="text-white text-decoration-none"><fmt:message key="poll.back.polls" /></a> &gt;
            <span class="text-white"><c:out value="${poll.question}"/></span>
        </nav>
        <h1 class="display-5"><c:out value="${poll.question}"/></h1>
        <div class="mt-3">
            <span class="badge bg-light text-dark me-2"><i class="bi bi-people"></i> ${totalVotes} <fmt:message key="poll.total.votes" /></span>
            <span class="badge bg-light text-dark"><i class="bi bi-chat"></i> ${poll.comments != null ? poll.comments.size() : 0} <fmt:message key="poll.comments" /></span>
        </div>
    </div>
</div>

<div class="container mb-5">
    <div class="row">
        <div class="col-lg-8">
            <div class="poll-card">
                <div class="poll-card-header">
                    <h3 class="mb-0"><i class="bi bi-bar-chart-fill me-2"></i><fmt:message key="poll.cast.vote" /></h3>
                </div>
                <div class="p-4">
                    <c:if test="${userVote != null}">
                        <div class="user-vote">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            <strong><fmt:message key="poll.your.vote" /></strong> <c:out value="${userVote.pollOption.optionText}"/>
                            <span class="float-end"><small><fmt:message key="poll.change.vote" /></small></span>
                        </div>
                    </c:if>
                    
                    <c:if test="${empty isLoggedIn}">
                        <div class="alert alert-info">
                            <a href="/login" class="alert-link"><fmt:message key="poll.login.to.vote" /></a>
                        </div>
                    </c:if>
                    
                    <form action="/poll/${poll.id}/vote" method="post">
                        <c:forEach var="option" items="${options}" varStatus="status">
                            <div class="poll-option">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="optionId" 
                                           value="${option.id}" id="option${option.id}"
                                           ${userVote != null && userVote.pollOption.id == option.id ? 'checked' : ''}
                                           ${empty isLoggedIn ? 'disabled' : ''}>
                                    <label class="form-check-label fw-bold" for="option${option.id}">
                                        <c:out value="${option.optionText}"/>
                                    </label>
                                    <span class="float-end badge bg-secondary">
                                        <c:choose>
                                            <c:when test="${option.votes != null}">${option.votes.size()}</c:when>
                                            <c:otherwise>0</c:otherwise>
                                        </c:choose> <fmt:message key="poll.total.votes" />
                                    </span>
                                </div>
                                <div class="vote-progress">
                                    <div class="vote-progress-bar" style="width: ${totalVotes > 0 ? ((option.votes != null ? option.votes.size() : 0) * 100.0 / totalVotes) : 0}%"></div>
                                </div>
                            </div>
                        </c:forEach>
                        
                        <c:if test="${not empty isLoggedIn}">
                            <div class="mt-4 text-center">
                                <button type="submit" class="btn-vote">
                                    <i class="bi bi-check-circle me-2"></i>
                                    <c:choose>
                                        <c:when test="${userVote != null}"><fmt:message key="poll.update.vote" /></c:when>
                                        <c:otherwise><fmt:message key="poll.submit.vote" /></c:otherwise>
                                    </c:choose>
                                </button>
                            </div>
                        </c:if>
                    </form>
                </div>
            </div>
            
            <div class="chart-container">
                <h5><i class="bi bi-pie-chart-fill me-2" style="color: #e74c3c;"></i><fmt:message key="poll.vote.distribution" /></h5>
                <canvas id="voteChart" style="width: 100%; height: 300px;"></canvas>
            </div>
            
            <div class="poll-card">
                <div class="poll-card-header">
                    <h5 class="mb-0"><i class="bi bi-chat-dots me-2"></i><fmt:message key="poll.discussion" /></h5>
                </div>
                <div class="p-4">
                    <c:if test="${isLoggedIn}">
                        <form action="/poll/${poll.id}/comment" method="post" class="mb-4">
                            <textarea name="content" class="form-control mb-2" rows="3" placeholder="<fmt:message key='poll.share.thoughts' />"></textarea>
                            <button type="submit" class="btn btn-primary"><fmt:message key="poll.post.comment" /></button>
                        </form>
                    </c:if>
                    
                    <c:forEach var="comment" items="${comments}">
                        <div class="comment-card">
                            <div class="d-flex justify-content-between">
                                <strong><c:out value="${comment.user.fullName}"/></strong>
                                <small class="text-muted"><c:out value="${comment.formattedCreatedAt}"/></small>
                            </div>
                            <p class="mt-2 mb-0"><c:out value="${comment.content}"/></p>
                        </div>
                    </c:forEach>
                    <c:if test="${empty comments}">
                        <p class="text-muted text-center"><fmt:message key="poll.no.comments" /></p>
                    </c:if>
                </div>
            </div>
        </div>
        
        <div class="col-lg-4">
            <div class="poll-card">
                <div class="poll-card-header">
                    <h5><i class="bi bi-bar-chart-steps me-2"></i><fmt:message key="poll.statistics" /></h5>
                </div>
                <div class="p-4">
                    <div class="stat-item">
                        <span><fmt:message key="poll.total.votes.stat" /></span>
                        <strong class="text-danger">${totalVotes}</strong>
                    </div>
                    <div class="stat-item">
                        <span><fmt:message key="poll.total.comments" /></span>
                        <strong class="text-danger">${poll.comments != null ? poll.comments.size() : 0}</strong>
                    </div>
                    <div class="stat-item">
                        <span><fmt:message key="poll.created" /></span>
                        <strong class="text-danger">${formattedDate}</strong>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const ctx = document.getElementById('voteChart').getContext('2d');
        const options = [
            <c:forEach var="option" items="${options}" varStatus="status">
                '<c:out value="${option.optionText}"/>'${!status.last ? ',' : ''}
            </c:forEach>
        ];
        const votes = [
            <c:forEach var="option" items="${options}" varStatus="status">
                ${option.votes != null ? option.votes.size() : 0}${!status.last ? ',' : ''}
            </c:forEach>
        ];
        
        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: options,
                datasets: [{
                    data: votes,
                    backgroundColor: ['#3498db', '#e74c3c', '#f39c12', '#27ae60', '#9b59b6', '#1abc9c', '#e67e22', '#2ecc71'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    });
</script>
</body>
</html>
