<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'en'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Course Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .register-container {
            max-width: 500px;
            margin: 0 auto;
            padding-top: 80px;
            padding-bottom: 80px;
        }
        .register-card {
            background: white;
            border-radius: 30px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            overflow: hidden;
        }
        .register-header {
            background: linear-gradient(135deg, #2c3e50, #34495e);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .register-header i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #3498db;
        }
        .register-body {
            padding: 2rem;
        }
        .btn-register {
            background: linear-gradient(135deg, #27ae60, #229954);
            color: white;
            border: none;
            padding: 0.8rem;
            border-radius: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            width: 100%;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(39, 174, 96, 0.4);
        }
        .form-control {
            border-radius: 10px;
            padding: 0.8rem;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="register-container">
    <div class="register-card">
        <div class="register-header">
            <i class="bi bi-person-plus-fill"></i>
            <h2>Create Account</h2>
            <p>Join us to start learning</p>
        </div>
        <div class="register-body">
            <!-- 通用錯誤 -->
            <c:if test="${param.error != null && param.error != 'username' && param.error != 'email'}">
                <div class="alert alert-danger">Registration failed. Please try again.</div>
            </c:if>
            
            <!-- 用戶名已存在錯誤 -->
            <c:if test="${param.error == 'username'}">
                <div class="alert alert-danger">Username already exists. Please choose another.</div>
            </c:if>
            
            <!-- 郵箱已存在錯誤 -->
            <c:if test="${param.error == 'email'}">
                <div class="alert alert-danger">Email already registered. Please use another email or login.</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="fullName" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Phone</label>
                    <input type="tel" name="phone" class="form-control">
                </div>
                <button type="submit" class="btn-register">Register</button>
            </form>
            
            <div class="text-center mt-3">
                <a href="/login" class="text-decoration-none">Already have an account? Login</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
