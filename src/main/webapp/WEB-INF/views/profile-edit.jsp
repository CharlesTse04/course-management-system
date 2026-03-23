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
    <title><fmt:message key="edit.profile.title" /> - <fmt:message key="app.name" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .profile-container { max-width: 600px; margin: 2rem auto; }
        .profile-card { background: white; border-radius: 20px; box-shadow: 0 5px 20px rgba(0,0,0,0.1); overflow: hidden; }
        .profile-header { background: linear-gradient(135deg, #3498db, #2c3e50); color: white; padding: 2rem; text-align: center; }
        .profile-body { padding: 2rem; }
        .username-display { background: #f8f9fa; border-radius: 15px; padding: 1rem; margin-bottom: 1.5rem; border-left: 4px solid #3498db; }
        .btn-update { background: #3498db; color: white; border: none; padding: 0.8rem; border-radius: 10px; width: 100%; font-size: 1rem; transition: all 0.3s ease; }
        .btn-update:hover { background: #2980b9; transform: translateY(-2px); }
        .btn-back { background: #6c757d; color: white; border: none; padding: 0.8rem; border-radius: 10px; width: 100%; font-size: 1rem; margin-top: 0.5rem; transition: all 0.3s ease; }
        .btn-back:hover { background: #5a6268; transform: translateY(-2px); }
        .btn-back i, .btn-update i { margin-right: 8px; }
    </style>
</head>
<body class="bg-light">

<jsp:include page="header.jsp" />

<div class="profile-container">
    <div class="profile-card">
        <div class="profile-header">
            <i class="bi bi-pencil-square" style="font-size: 3rem;"></i>
            <h2 class="mt-3"><fmt:message key="edit.profile.title" /></h2>
            <p class="mb-0"><fmt:message key="edit.profile.subtitle" /></p>
        </div>
        
        <div class="profile-body">
            <c:if test="${param.passwordError == 'mismatch'}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i><fmt:message key="error.password.mismatch" />
                </div>
            </c:if>
            <c:if test="${param.passwordError == 'invalid'}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i><fmt:message key="error.password.invalid" />
                </div>
            </c:if>
            
            <div class="username-display">
                <small class="text-uppercase text-muted"><fmt:message key="edit.profile.username" /></small>
                <h5 class="mb-0">
                    <i class="bi bi-person me-2"></i><c:out value="${user.username}"/>
                </h5>
            </div>
            
            <!-- 更新個人資料表單 -->
            <form action="${pageContext.request.contextPath}/profile/update" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold"><fmt:message key="edit.profile.fullname" /></label>
                    <input type="text" class="form-control" name="fullName" value="${user.fullName}" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold"><fmt:message key="edit.profile.email" /></label>
                    <input type="email" class="form-control" name="email" value="${user.email}" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold"><fmt:message key="edit.profile.phone" /></label>
                    <input type="tel" class="form-control" name="phone" value="${user.phone}">
                </div>
                
                <div class="alert alert-info mb-4">
                    <i class="bi bi-info-circle me-2"></i>
                    <fmt:message key="edit.profile.role" />: <strong><c:out value="${user.role}"/></strong>
                </div>
                
                <button type="submit" class="btn-update">
                    <i class="bi bi-check-circle"></i> <fmt:message key="edit.profile.update" />
                </button>
            </form>
            
            <hr class="my-4">
            
            <!-- 修改密碼表單 -->
            <h5 class="mb-3"><i class="bi bi-lock me-2"></i><fmt:message key="edit.profile.change.password" /></h5>
            
            <form action="${pageContext.request.contextPath}/profile/change-password" method="post">
                <div class="mb-3">
                    <label class="form-label"><fmt:message key="edit.profile.current.password" /></label>
                    <input type="password" class="form-control" name="currentPassword" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label"><fmt:message key="edit.profile.new.password" /></label>
                    <input type="password" class="form-control" name="newPassword" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label"><fmt:message key="edit.profile.confirm.password" /></label>
                    <input type="password" class="form-control" name="confirmPassword" required>
                </div>
                
                <button type="submit" class="btn btn-warning w-100 py-2">
                    <i class="bi bi-key me-2"></i><fmt:message key="edit.profile.change.password" />
                </button>
            </form>
            
            <div class="text-center mt-3">
                <a href="/profile" class="btn-back btn">
                    <i class="bi bi-arrow-left"></i> <fmt:message key="edit.profile.back" />
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
