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
    <title><fmt:message key="create.poll.title" /> - <fmt:message key="app.name" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { background-color: #f5f5f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .page-header { background: linear-gradient(135deg, #2c3e50, #e74c3c); color: white; padding: 3rem 0; margin-bottom: 2rem; }
        .page-title { font-size: 2.5rem; font-weight: 700; margin-bottom: 1rem; }
        .form-card { background: white; border-radius: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 2rem; overflow: hidden; }
        .form-header { padding: 1.5rem; border-bottom: 1px solid #e9ecef; background: #f8f9fa; }
        .form-body { padding: 2rem; }
        .btn-submit { background: #e74c3c; color: white; border: none; padding: 0.8rem 2rem; border-radius: 30px; font-weight: 600; transition: all 0.3s ease; }
        .btn-submit:hover { background: #c0392b; transform: translateY(-2px); }
        .btn-back { background: #6c757d; color: white; border: none; padding: 0.8rem 2rem; border-radius: 30px; transition: all 0.3s ease; }
        .btn-back:hover { background: #5a6268; }
        .option-card { background: #f8f9fa; border-radius: 12px; padding: 1rem; margin-bottom: 1rem; }
        .option-number { display: inline-block; width: 30px; height: 30px; background: #e74c3c; color: white; border-radius: 50%; text-align: center; line-height: 30px; font-weight: bold; margin-right: 0.5rem; }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="page-header">
    <div class="container">
        <a href="/polls" class="btn-back mb-3 d-inline-block">
            <i class="bi bi-arrow-left me-1"></i> <fmt:message key="create.poll.back" />
        </a>
        <h1 class="page-title">
            <i class="bi bi-plus-circle me-3"></i>
            <fmt:message key="create.poll.title" />
        </h1>
        <p class="lead mb-0"><fmt:message key="create.poll.subtitle" /></p>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="form-card">
                <div class="form-header">
                    <h5 class="mb-0"><i class="bi bi-question-circle me-2"></i><fmt:message key="create.poll.basic.info" /></h5>
                </div>
                <div class="form-body">
                    <form action="/poll/create" method="post">
                        <!-- Question -->
                        <div class="mb-4">
                            <label class="form-label fw-bold"><fmt:message key="create.poll.question.label" /> <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="question" required 
                                   placeholder="<fmt:message key='create.poll.question.placeholder' />">
                        </div>
                        
                        <!-- Options -->
                        <div class="mb-4">
                            <label class="form-label fw-bold"><fmt:message key="create.poll.options.label" /> <span class="text-danger">*</span></label>
                            <div class="option-card">
                                <span class="option-number">1</span>
                                <input type="text" class="form-control d-inline-block w-75" name="option1" required 
                                       placeholder="<fmt:message key='create.poll.option.placeholder' />">
                            </div>
                            <div class="option-card">
                                <span class="option-number">2</span>
                                <input type="text" class="form-control d-inline-block w-75" name="option2" required 
                                       placeholder="<fmt:message key='create.poll.option.placeholder' />">
                            </div>
                            <div class="option-card">
                                <span class="option-number">3</span>
                                <input type="text" class="form-control d-inline-block w-75" name="option3" required 
                                       placeholder="<fmt:message key='create.poll.option.placeholder' />">
                            </div>
                            <div class="option-card">
                                <span class="option-number">4</span>
                                <input type="text" class="form-control d-inline-block w-75" name="option4" required 
                                       placeholder="<fmt:message key='create.poll.option.placeholder' />">
                            </div>
                            <div class="option-card">
                                <span class="option-number">5</span>
                                <input type="text" class="form-control d-inline-block w-75" name="option5" required 
                                       placeholder="<fmt:message key='create.poll.option.placeholder' />">
                            </div>
                        </div>
                        
                        <!-- Active Status -->
                        <div class="mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="active" value="true" id="active" checked>
                                <label class="form-check-label fw-bold" for="active">
                                    <fmt:message key="create.poll.active.label" />
                                </label>
                                <div class="form-text"><fmt:message key="create.poll.active.hint" /></div>
                            </div>
                        </div>
                        
                        <!-- Buttons -->
                        <div class="d-flex gap-3 mt-4">
                            <button type="submit" class="btn-submit">
                                <i class="bi bi-check-circle me-2"></i><fmt:message key="create.poll.submit" />
                            </button>
                            <a href="/polls" class="btn-back btn">
                                <i class="bi bi-x-circle me-2"></i><fmt:message key="create.poll.cancel" />
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
