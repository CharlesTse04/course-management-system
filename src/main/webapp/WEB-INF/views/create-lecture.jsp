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
    <title><fmt:message key="create.lecture.title" /> - <fmt:message key="app.name" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { background-color: #f5f5f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .page-header { background: linear-gradient(135deg, #2c3e50, #3498db); color: white; padding: 3rem 0; margin-bottom: 2rem; }
        .page-title { font-size: 2.5rem; font-weight: 700; margin-bottom: 1rem; }
        .form-card { background: white; border-radius: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 2rem; overflow: hidden; }
        .form-header { padding: 1.5rem; border-bottom: 1px solid #e9ecef; background: #f8f9fa; }
        .form-body { padding: 2rem; }
        .btn-submit { background: #27ae60; color: white; border: none; padding: 0.8rem 2rem; border-radius: 30px; font-weight: 600; transition: all 0.3s ease; }
        .btn-submit:hover { background: #229954; transform: translateY(-2px); }
        .btn-back { background: #6c757d; color: white; border: none; padding: 0.8rem 2rem; border-radius: 30px; transition: all 0.3s ease; }
        .btn-back:hover { background: #5a6268; }
        .upload-area { border: 2px dashed #3498db; border-radius: 15px; padding: 2rem; text-align: center; cursor: pointer; transition: all 0.3s ease; }
        .upload-area:hover { background: #e3f0ff; border-color: #2980b9; }
        .file-list { margin-top: 1rem; }
        .file-item { background: #f8f9fa; padding: 0.5rem 1rem; border-radius: 8px; margin-bottom: 0.5rem; display: flex; justify-content: space-between; align-items: center; }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="page-header">
    <div class="container">
        <a href="/lectures" class="btn-back mb-3 d-inline-block">
            <i class="bi bi-arrow-left me-1"></i> <fmt:message key="create.lecture.back" />
        </a>
        <h1 class="page-title">
            <i class="bi bi-plus-circle me-3"></i>
            <fmt:message key="create.lecture.title" />
        </h1>
        <p class="lead mb-0"><fmt:message key="create.lecture.subtitle" /></p>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="form-card">
                <div class="form-header">
                    <h5 class="mb-0"><i class="bi bi-info-circle me-2"></i><fmt:message key="create.lecture.basic.info" /></h5>
                </div>
                <div class="form-body">
                    <form action="/lecture/create" method="post" enctype="multipart/form-data">
                        <!-- Title -->
                        <div class="mb-3">
                            <label class="form-label fw-bold"><fmt:message key="create.lecture.title.label" /> <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="title" required 
                                   placeholder="<fmt:message key='create.lecture.title.placeholder' />">
                        </div>
                        
                        <!-- Description -->
                        <div class="mb-3">
                            <label class="form-label fw-bold"><fmt:message key="create.lecture.description.label" /> <span class="text-danger">*</span></label>
                            <textarea class="form-control" name="description" rows="3" required 
                                      placeholder="<fmt:message key='create.lecture.description.placeholder' />"></textarea>
                        </div>
                        
                        <!-- Detailed Summary -->
                        <div class="mb-3">
                            <label class="form-label fw-bold"><fmt:message key="create.lecture.summary.label" /></label>
                            <textarea class="form-control" name="detailedSummary" rows="5" 
                                      placeholder="<fmt:message key='create.lecture.summary.placeholder' />"></textarea>
                        </div>
                        
                        <!-- Instructor Name -->
                        <div class="mb-3">
                            <label class="form-label fw-bold"><fmt:message key="create.lecture.instructor.label" /></label>
                            <input type="text" class="form-control" name="instructorName" 
                                   placeholder="<fmt:message key='create.lecture.instructor.placeholder' />">
                            <div class="form-text"><fmt:message key="create.lecture.instructor.hint" /></div>
                        </div>
                        
                        <!-- Instructor Bio -->
                        <div class="mb-3">
                            <label class="form-label fw-bold"><fmt:message key="create.lecture.bio.label" /></label>
                            <textarea class="form-control" name="instructorBio" rows="3" 
                                      placeholder="<fmt:message key='create.lecture.bio.placeholder' />"></textarea>
                        </div>
                        
                        <!-- Materials Upload -->
                        <div class="mb-4">
                            <label class="form-label fw-bold"><fmt:message key="create.lecture.materials.label" /></label>
                            <div class="upload-area" onclick="document.getElementById('fileInput').click()">
                                <i class="bi bi-cloud-upload fs-1"></i>
                                <p class="mt-2 mb-0"><fmt:message key="create.lecture.materials.upload" /></p>
                                <small class="text-muted"><fmt:message key="create.lecture.materials.hint" /></small>
                                <input type="file" id="fileInput" name="materials" multiple style="display: none;" onchange="updateFileList()">
                            </div>
                            <div id="fileList" class="file-list"></div>
                        </div>
                        
                        <!-- Buttons -->
                        <div class="d-flex gap-3 mt-4">
                            <button type="submit" class="btn-submit">
                                <i class="bi bi-check-circle me-2"></i><fmt:message key="create.lecture.submit" />
                            </button>
                            <a href="/lectures" class="btn-back btn">
                                <i class="bi bi-x-circle me-2"></i><fmt:message key="create.lecture.cancel" />
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

<script>
    function updateFileList() {
        const input = document.getElementById('fileInput');
        const fileList = document.getElementById('fileList');
        fileList.innerHTML = '';
        
        if (input.files.length > 0) {
            for (let i = 0; i < input.files.length; i++) {
                const file = input.files[i];
                const sizeKB = file.size / 1024;
                const sizeDisplay = sizeKB >= 1024 ? (sizeKB / 1024).toFixed(2) + ' MB' : sizeKB.toFixed(2) + ' KB';
                
                const div = document.createElement('div');
                div.className = 'file-item';
                div.innerHTML = `
                    <span><i class="bi bi-file-earmark me-2"></i>${file.name} (${sizeDisplay})</span>
                    <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeFile(${i})">
                        <i class="bi bi-trash"></i>
                    </button>
                `;
                fileList.appendChild(div);
            }
        }
    }
    
    function removeFile(index) {
        const input = document.getElementById('fileInput');
        const dt = new DataTransfer();
        for (let i = 0; i < input.files.length; i++) {
            if (i !== index) {
                dt.items.add(input.files[i]);
            }
        }
        input.files = dt.files;
        updateFileList();
    }
</script>
</body>
</html>
