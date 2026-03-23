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
    <title><fmt:message key="login.title" /> - <fmt:message key="app.name" /></title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --success-color: #27ae60;
            --light-bg: #f8f9fa;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        
        .login-container {
            width: 100%;
            max-width: 450px;
            margin: 0 auto;
            padding-top: 100px;
            padding-bottom: 50px;
        }
        
        .login-card {
            background: white;
            border-radius: 30px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            overflow: hidden;
            animation: slideUp 0.5s ease;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .login-header {
            background: linear-gradient(135deg, var(--primary-color), #34495e);
            color: white;
            padding: 2rem 2rem;
            text-align: center;
        }
        
        .login-header i {
            font-size: 3.5rem;
            margin-bottom: 0.8rem;
            color: var(--secondary-color);
        }
        
        .login-header h2 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.3rem;
        }
        
        .login-header p {
            opacity: 0.9;
            margin: 0;
            font-size: 0.9rem;
        }
        
        .login-body {
            padding: 2rem;
        }
        
        .form-floating {
            margin-bottom: 1rem;
        }
        
        .form-floating input {
            border-radius: 12px;
            border: 1px solid #e9ecef;
            padding: 1rem;
            height: auto;
        }
        
        .form-floating input:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.1);
        }
        
        .form-floating label {
            padding: 0.8rem;
        }
        
        .input-icon {
            position: relative;
        }
        
        .input-icon i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #adb5bd;
            z-index: 10;
            font-size: 1rem;
        }
        
        .input-icon input {
            padding-left: 38px;
        }
        
        .btn-login {
            background: linear-gradient(135deg, var(--secondary-color), #2980b9);
            color: white;
            border: none;
            padding: 0.8rem;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 0.5rem;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
            color: white;
        }
        
        .forgot-password {
            text-align: right;
            margin-bottom: 0.5rem;
        }
        
        .forgot-password a {
            color: #6c757d;
            text-decoration: none;
            font-size: 0.8rem;
        }
        
        .forgot-password a:hover {
            color: var(--secondary-color);
        }
        
        .register-link {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e9ecef;
        }
        
        .register-link p {
            color: #6c757d;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }
        
        .register-link a {
            color: var(--secondary-color);
            font-weight: 600;
            text-decoration: none;
            font-size: 0.9rem;
        }
        
        .register-link a:hover {
            color: var(--accent-color);
        }
        
        .alert-custom {
            border-radius: 12px;
            padding: 0.8rem;
            margin-bottom: 1rem;
            border: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.85rem;
        }
        
        .alert-danger {
            background: #fee9e7;
            color: var(--accent-color);
        }
        
        .alert-success {
            background: #d4edda;
            color: var(--success-color);
        }
        
        .demo-credentials {
            background: var(--light-bg);
            border-radius: 12px;
            padding: 1rem;
            margin-top: 1.2rem;
        }
        
        .demo-credentials h6 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 0.8rem;
            font-size: 0.9rem;
        }
        
        .demo-item {
            display: flex;
            justify-content: space-between;
            padding: 0.4rem 0;
            border-bottom: 1px dashed #dee2e6;
            font-size: 0.85rem;
        }
        
        .demo-item:last-child {
            border-bottom: none;
        }
        
        .demo-item code {
            font-size: 0.8rem;
        }
        
        .loading-spinner {
            display: none;
            width: 16px;
            height: 16px;
            border: 2px solid rgba(255,255,255,0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
            margin-left: 0.5rem;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .btn-login.loading .loading-spinner {
            display: inline-block;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 1rem;
            font-size: 0.8rem;
        }
        
        @media (max-width: 480px) {
            .login-container {
                padding-top: 60px;
                padding-left: 15px;
                padding-right: 15px;
            }
            .login-header {
                padding: 1.5rem;
            }
            .login-body {
                padding: 1.5rem;
            }
            .login-header h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="login-container">
    <div class="login-card">
        <div class="login-header">
            <i class="bi bi-mortarboard-fill"></i>
            <h2><fmt:message key="login.title" /></h2>
            <p><fmt:message key="login.subtitle" /></p>
        </div>
        
        <div class="login-body">
            <c:if test="${param.error != null}">
                <div class="alert-custom alert-danger">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    <span><fmt:message key="error.invalid.credentials" /></span>
                </div>
            </c:if>
            
            <c:if test="${param.registered != null}">
                <div class="alert-custom alert-success">
                    <i class="bi bi-check-circle-fill"></i>
                    <span><fmt:message key="success.registration" /></span>
                </div>
            </c:if>
            
            <c:if test="${param.logout != null}">
                <div class="alert-custom alert-success">
                    <i class="bi bi-check-circle-fill"></i>
                    <span><fmt:message key="success.logout" /></span>
                </div>
            </c:if>
            
            <!-- Login Form - 添加 CSRF Token -->
            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm" onsubmit="showLoading()">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                
                <div class="form-floating input-icon mb-3">
                    <i class="bi bi-person"></i>
                    <input type="text" class="form-control" id="username" name="username" 
                           placeholder="<fmt:message key='login.username' />" required autofocus>
                    <label for="username"><fmt:message key="login.username" /></label>
                </div>
                
                <div class="form-floating input-icon mb-3">
                    <i class="bi bi-lock"></i>
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="<fmt:message key='login.password' />" required>
                    <label for="password"><fmt:message key="login.password" /></label>
                </div>
                
                <div class="forgot-password">
                    <a href="${pageContext.request.contextPath}/forgot-password">
                        <i class="bi bi-question-circle me-1"></i><fmt:message key="login.forgot.password" />
                    </a>
                </div>
                
                <button type="submit" class="btn-login" id="submitBtn">
                    <span><fmt:message key="login.sign.in" /></span>
                    <span class="loading-spinner"></span>
                </button>
            </form>
            
            <!-- Demo Credentials - 修正密碼為 password -->
            <div class="demo-credentials">
                <h6><i class="bi bi-info-circle me-2"></i><fmt:message key="demo.title" /></h6>
                <div class="demo-item">
                    <span><i class="bi bi-person-badge me-2 text-primary"></i><fmt:message key="demo.teacher" /></span>
                    <span><code>teacher</code> / <code>password</code></span>
                </div>
                <div class="demo-item">
                    <span><i class="bi bi-person me-2 text-success"></i><fmt:message key="demo.student" /></span>
                    <span><code>student</code> / <code>password</code></span>
                </div>
            </div>
            
            <div class="register-link">
                <p><fmt:message key="login.no.account" /></p>
                <a href="${pageContext.request.contextPath}/register">
                    <i class="bi bi-person-plus me-2"></i><fmt:message key="login.create.account" />
                </a>
            </div>
            
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/" class="text-muted text-decoration-none small back-link">
                    <i class="bi bi-arrow-left me-1"></i><fmt:message key="login.back.home" />
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function showLoading() {
        const btn = document.getElementById('submitBtn');
        btn.classList.add('loading');
        btn.disabled = true;
    }
    
    function fillDemoCredentials(role) {
        if (role === 'teacher') {
            document.getElementById('username').value = 'teacher';
            document.getElementById('password').value = 'password';
        } else if (role === 'student') {
            document.getElementById('username').value = 'student';
            document.getElementById('password').value = 'password';
        }
    }
    
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey && e.shiftKey && e.key === 'T') {
            e.preventDefault();
            fillDemoCredentials('teacher');
        } else if (e.ctrlKey && e.shiftKey && e.key === 'S') {
            e.preventDefault();
            fillDemoCredentials('student');
        }
    });
</script>

</body>
</html>
