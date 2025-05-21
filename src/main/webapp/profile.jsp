<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.payment.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Profile - Photography Service</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4F46E5;
            --primary-light: #818CF8;
            --primary-dark: #3730A3;
            --success-color: #10B981;
            --warning-color: #F59E0B;
            --danger-color: #EF4444;
            --background: #F8FAFC;
            --card-bg: #FFFFFF;
            --text-primary: #1E293B;
            --text-secondary: #64748B;
        }

        body {
            background: var(--background);
            font-family: 'Inter', sans-serif;
            color: var(--text-primary);
            min-height: 100vh;
        }

        .navbar {
            background: #1E293B !important;
            padding: 1rem 0;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 600;
            color: white;
        }

        .nav-link {
            color: rgba(255,255,255,0.8) !important;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            transition: all 0.2s ease;
        }

        .nav-link:hover {
            color: white !important;
            background: rgba(255,255,255,0.1);
        }

        .nav-link i {
            width: 1.5rem;
        }

        .profile-card {
            background: var(--card-bg);
            border: none;
            border-radius: 1rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        .profile-header {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            padding: 2rem;
            position: relative;
            overflow: hidden;
        }

        .profile-header::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            transform: translate(30%, -30%);
        }

        .profile-body {
            padding: 2rem;
        }

        .form-label {
            color: var(--text-primary);
            font-weight: 500;
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border-radius: 0.75rem;
            padding: 0.75rem 1rem;
            border: 1px solid rgba(0,0,0,0.1);
            background-color: #F8FAFC;
            transition: all 0.2s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
            background-color: white;
        }

        .input-group-text {
            border-radius: 0.75rem;
            background-color: #F8FAFC;
            border: 1px solid rgba(0,0,0,0.1);
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 0.75rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .btn-primary {
            background: var(--primary-color);
            border: none;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }

        .alert {
            border: none;
            border-radius: 0.75rem;
            padding: 1rem 1.5rem;
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .form-section {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border: 1px solid rgba(0,0,0,0.05);
        }

        .form-section-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-section-title i {
            color: var(--primary-color);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="fas fa-camera me-2"></i>Photography Service</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<%= "PHOTOGRAPHER".equals(user.getUserType()) ? "photographer-dashboard.jsp" : "client-dashboard.jsp" %>">
                            <i class="fas fa-home me-2"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout">
                            <i class="fas fa-sign-out-alt me-2"></i>Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="profile-card">
                    <div class="profile-header">
                        <h3 class="mb-1"><i class="fas fa-user-circle me-2"></i>Profile Settings</h3>
                        <p class="mb-0 opacity-75">Update your personal information and account settings</p>
                    </div>
                    <div class="profile-body">
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        <% if (request.getAttribute("success") != null) { %>
                            <div class="alert alert-success" role="alert">
                                <i class="fas fa-check-circle me-2"></i>
                                <%= request.getAttribute("success") %>
                            </div>
                        <% } %>
                        
                        <form action="update-profile" method="post" id="profileForm">
                            <div class="form-section">
                                <div class="form-section-title">
                                    <i class="fas fa-user"></i>Personal Information
                                </div>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="name" class="form-label">Full Name</label>
                                        <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="email" class="form-label">Email Address</label>
                                        <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="phone" class="form-label">Phone Number</label>
                                        <input type="tel" class="form-control" id="phone" name="phone" value="<%= user.getPhone() %>" required>
                                    </div>
                                </div>
                            </div>

                            <% if ("PHOTOGRAPHER".equals(user.getUserType())) { %>
                            <div class="form-section">
                                <div class="form-section-title">
                                    <i class="fas fa-camera"></i>Professional Details
                                </div>
                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <label for="portfolioLink" class="form-label">Portfolio Link</label>
                                        <input type="url" class="form-control" id="portfolioLink" name="portfolioLink" 
                                               value="<%= user.getPortfolioLink() != null ? user.getPortfolioLink() : "" %>">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="specialization" class="form-label">Specialization</label>
                                        <select class="form-select" id="specialization" name="specialization">
                                            <option value="PHOTO" <%= "PHOTO".equals(user.getSpecialization()) ? "selected" : "" %>>Photography</option>
                                            <option value="VIDEO" <%= "VIDEO".equals(user.getSpecialization()) ? "selected" : "" %>>Videography</option>
                                            <option value="BOTH" <%= "BOTH".equals(user.getSpecialization()) ? "selected" : "" %>>Both</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <% } %>

                            <div class="form-section">
                                <div class="form-section-title">
                                    <i class="fas fa-lock"></i>Security
                                </div>
                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <label for="currentPassword" class="form-label">Current Password</label>
                                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="newPassword" class="form-label">New Password</label>
                                        <input type="password" class="form-control" id="newPassword" name="newPassword" 
                                               placeholder="Leave blank if no change">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                                    </div>
                                </div>
                            </div>

                            <div class="text-end mt-4">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Save Changes
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('profileForm').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const currentPassword = document.getElementById('currentPassword').value;
            
            if (!currentPassword) {
                e.preventDefault();
                alert('Current password is required to make changes');
                return;
            }
            
            if (newPassword && newPassword !== confirmPassword) {
                e.preventDefault();
                alert('New passwords do not match!');
                return;
            }
        });
    </script>
</body>
</html>
