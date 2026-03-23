<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'en'}" />
<fmt:setBundle basename="i18n/messages" />

<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'en'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="profile.title" /> - <fmt:message key="app.name" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .profile-container { max-width: 700px; margin: 2rem auto; }
        .profile-card { background: white; border-radius: 20px; box-shadow: 0 5px 20px rgba(0,0,0,0.1); overflow: hidden; }
        .profile-header { background: linear-gradient(135deg, #3498db, #2c3e50); color: white; padding: 2rem; text-align: center; }
        .profile-body { padding: 2rem; }
        .info-row { display: flex; padding: 1rem 0; border-bottom: 1px solid #e9ecef; }
        .info-label { width: 120px; font-weight: 600; color: #6c757d; }
        .info-value { flex: 1; color: #2c3e50; }
        .btn-edit { background: #3498db; color: white; border: none; padding: 0.8rem; border-radius: 10px; width: 100%; font-size: 1rem; transition: all 0.3s ease; }
        .btn-edit:hover { background: #2980b9; transform: translateY(-2px); }
        .btn-back { background: #6c757d; color: white; border: none; padding: 0.8rem; border-radius: 10px; width: 100%; font-size: 1rem; margin-top: 0.5rem; transition: all 0.3s ease; }
        .btn-back:hover { background: #5a6268; transform: translateY(-2px); }
        .btn-back i, .btn-edit i { margin-right: 8px; }
    </style>
</head>
<body class="bg-light">

<jsp:include page="header.jsp" />

<div class="profile-container">
    <div class="profile-card">
        <div class="profile-header">
            <i class="bi bi-person-circle" style="font-size: 3rem;"></i>
            <h2 class="mt-3"><fmt:message key="profile.title" /></h2>
            <p class="mb-0"><fmt:message key="profile.subtitle" /></p>
        </div>
        
        <div class="profile-body">
            <c:if test="${param.success != null}">
                <div class="alert alert-success">
                    <i class="bi bi-check-circle-fill me-2"></i><fmt:message key="profile.update.success" />
                </div>
            </c:if>
            <c:if test="${param.passwordChanged != null}">
                <div class="alert alert-success">
                    <i class="bi bi-check-circle-fill me-2"></i><fmt:message key="profile.password.changed" />
                </div>
            </c:if>
            
            <div class="info-row">
                <div class="info-label"><fmt:message key="profile.username" />:</div>
                <div class="info-value"><c:out value="${user.username}"/></div>
            </div>
            <div class="info-row">
                <div class="info-label"><fmt:message key="profile.fullname" />:</div>
                <div class="info-value"><c:out value="${user.fullName}"/></div>
            </div>
            <div class="info-row">
                <div class="info-label"><fmt:message key="profile.email" />:</div>
                <div class="info-value"><c:out value="${user.email}"/></div>
            </div>
            <div class="info-row">
                <div class="info-label"><fmt:message key="profile.phone" />:</div>
                <div class="info-value"><c:out value="${user.phone}"/></div>
            </div>
            <div class="info-row">
                <div class="info-label"><fmt:message key="profile.role" />:</div>
                <div class="info-value"><c:out value="${user.role}"/></div>
            </div>
            <div class="info-row">
                <div class="info-label"><fmt:message key="profile.member.since" />:</div>
                <div class="info-value"><c:out value="${user.createdAt}"/></div>
            </div>
            
            <div class="mt-4">
                <a href="/profile/edit" class="btn-edit btn">
                    <i class="bi bi-pencil"></i> <fmt:message key="profile.edit" />
                </a>
                <a href="/" class="btn-back btn">
                    <i class="bi bi-house-door"></i> <fmt:message key="profile.back" />
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
