<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Footer -->
<footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5><i class="bi bi-mortarboard-fill me-2"></i>EduPortal</h5>
                <p class="text-muted">Advanced Web Development Course Portal</p>
            </div>
            <div class="col-md-3">
                <h6>Quick Links</h6>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/lectures" class="text-white-50 text-decoration-none">Lectures</a></li>
                    <li><a href="${pageContext.request.contextPath}/polls" class="text-white-50 text-decoration-none">Polls</a></li>
                    <li><a href="${pageContext.request.contextPath}/about" class="text-white-50 text-decoration-none">About</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h6>Contact</h6>
                <ul class="list-unstyled text-white-50">
                    <li><i class="bi bi-envelope me-2"></i>course@eduportal.com</li>
                    <li><i class="bi bi-telephone me-2"></i>+852 1234 5678</li>
                </ul>
            </div>
        </div>
        <div class="text-center mt-3">
            <small>&copy; 2026 EduPortal. All rights reserved.</small>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
