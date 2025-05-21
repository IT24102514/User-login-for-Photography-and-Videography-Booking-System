<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.payment.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"CLIENT".equals(user.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Client Dashboard - Photography Service</title>
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
        }

        .sidebar {
            background: #1E293B;
            min-height: 100vh;
            padding: 1.5rem;
            position: fixed;
            width: inherit;
            max-width: inherit;
        }

        .main-content {
            margin-left: auto;
            padding: 2rem;
        }

        .nav-link {
            color: #94A3B8 !important;
            padding: 0.875rem 1rem;
            border-radius: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            transition: all 0.2s ease;
            margin-bottom: 0.5rem;
        }

        .nav-link:hover, .nav-link.active {
            color: #FFFFFF !important;
            background: rgba(255, 255, 255, 0.1);
        }

        .nav-link i {
            font-size: 1.25rem;
            width: 1.5rem;
        }

        .profile-section {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border-radius: 1.5rem;
            padding: 2rem;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .profile-section::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            transform: translate(30%, -30%);
        }

        .profile-image {
            width: 80px;
            height: 80px;
            border-radius: 1rem;
            object-fit: cover;
            border: 3px solid rgba(255,255,255,0.2);
            background: white;
        }

        .welcome-text {
            color: rgba(255,255,255,0.9);
            font-size: 0.875rem;
            margin-bottom: 0.25rem;
        }

        .user-name {
            color: #FFFFFF;
            font-size: 1.875rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .stat-card {
            background: var(--card-bg);
            border-radius: 1rem;
            padding: 1.5rem;
            height: 100%;
            border: 1px solid rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            border-color: rgba(79, 70, 229, 0.1);
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            font-size: 1.5rem;
        }

        .icon-primary {
            background: rgba(79, 70, 229, 0.1);
            color: var(--primary-color);
        }

        .icon-success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .icon-warning {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 0.875rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 0.5rem;
        }

        .stat-value {
            color: var(--text-primary);
            font-size: 1.875rem;
            font-weight: 700;
            line-height: 1;
        }

        .booking-list {
            background: var(--card-bg);
            border-radius: 1rem;
            padding: 1.5rem;
            border: 1px solid rgba(0,0,0,0.05);
        }

        .booking-item {
            padding: 1rem;
            border-radius: 0.75rem;
            margin-bottom: 1rem;
            background: #F8FAFC;
            border: 1px solid rgba(0,0,0,0.05);
            transition: all 0.2s ease;
        }

        .booking-item:hover {
            background: #FFFFFF;
            border-color: rgba(79, 70, 229, 0.1);
            transform: translateX(5px);
        }

        .btn-custom {
            padding: 0.75rem 1.5rem;
            border-radius: 0.75rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
        }

        .btn-primary {
            background: var(--primary-color);
            border: none;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
        }

        .modal-content {
            border-radius: 1rem;
            border: none;
        }

        .modal-header {
            border-bottom: none;
            padding: 1.5rem;
        }

        .modal-body {
            padding: 1.5rem;
        }

        .modal-footer {
            border-top: none;
            padding: 1.5rem;
        }

        .alert {
            border-radius: 0.75rem;
            border: none;
            padding: 1rem 1.5rem;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 sidebar">
                <div class="text-center mb-4">
                    <img src="https://via.placeholder.com/80" class="rounded-circle mb-2" alt="Profile">
                    <h5 class="mb-0 text-white">Welcome, <%= user.getName() %></h5>
                    <small class="text-white-50">Client</small>
                </div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="profile.jsp">
                            <i class="fas fa-user"></i> Profile
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </li>
                    <li class="nav-item mt-4">
                        <a class="nav-link text-danger" href="#" data-bs-toggle="modal" data-bs-target="#deactivateModal">
                            <i class="fas fa-user-times"></i> Deactivate Account
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <!-- Profile Header -->
                <div class="profile-section">
                    <div class="row align-items-center">
                        <div class="col-auto">
                            <img src="https://via.placeholder.com/80" class="profile-image rounded-circle" alt="Profile">
                        </div>
                        <div class="col">
                            <div class="welcome-text">Welcome back,</div>
                            <h1 class="user-name"><%= user.getName() %> 👋</h1>
                            <p class="mb-0 text-white-50">We're glad to see you again!</p>
                        </div>
                        <div class="col-auto">
                            <a href="book-service.jsp" class="btn btn-primary">
                                <i class="fas fa-plus me-2"></i>New Booking
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Stats Row -->
                <div class="row mb-4">
                    <div class="col-md-4">
                        <div class="stat-card">
                            <div class="row align-items-center">
                                <div class="col">
                                    <div class="stat-icon icon-primary">
                                        <i class="fas fa-calendar"></i>
                                    </div>
                                    <h6 class="stat-label text-uppercase text-muted mb-2">Upcoming Bookings</h6>
                                    <h3 class="stat-value mb-0">2</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card">
                            <div class="row align-items-center">
                                <div class="col">
                                    <div class="stat-icon icon-success">
                                        <i class="fas fa-check-circle"></i>
                                    </div>
                                    <h6 class="stat-label text-uppercase text-muted mb-2">Completed Sessions</h6>
                                    <h3 class="stat-value mb-0">5</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card">
                            <div class="row align-items-center">
                                <div class="col">
                                    <div class="stat-icon icon-warning">
                                        <i class="fas fa-dollar-sign"></i>
                                    </div>
                                    <h6 class="stat-label text-uppercase text-muted mb-2">Total Spent</h6>
                                    <h3 class="stat-value mb-0">$1,250</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Bookings Section -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="booking-list">
                            <h5 class="mb-4"><i class="fas fa-clock me-2"></i>Recent Bookings</h5>
                            <div class="booking-item">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <h6 class="mb-1">Wedding Photography</h6>
                                        <p class="text-muted mb-0"><i class="fas fa-calendar me-2"></i>May 15, 2025</p>
                                    </div>
                                    <div class="col-auto">
                                        <span class="badge bg-primary">Upcoming</span>
                                    </div>
                                </div>
                            </div>
                            <div class="booking-item">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <h6 class="mb-1">Portrait Session</h6>
                                        <p class="text-muted mb-0"><i class="fas fa-calendar me-2"></i>May 10, 2025</p>
                                    </div>
                                    <div class="col-auto">
                                        <span class="badge bg-success">Completed</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Deactivate Account Modal -->
    <div class="modal fade" id="deactivateModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-exclamation-triangle text-warning me-2"></i>Deactivate Account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to deactivate your account? This action cannot be undone.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form action="deactivate-account" method="post" style="display: inline;">
                        <button type="submit" class="btn btn-danger">Deactivate Account</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Handle account deactivation
        document.getElementById('confirmDeactivate').addEventListener('click', function() {
            const password = document.getElementById('deactivatePassword').value;
            if (!password) {
                alert('Please enter your password');
                return;
            }

            if (!confirm('Are you absolutely sure you want to deactivate your account? This action cannot be undone.')) {
                return;
            }

            fetch('deactivate-account', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'password=' + encodeURIComponent(password)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Account deactivated successfully');
                    window.location.href = 'login.jsp';
                } else {
                    alert(data.message || 'Failed to deactivate account');
                }
            })
            .catch(error => {
                alert('An error occurred while deactivating your account');
                console.error('Error:', error);
            });
        });
    </script>
</body>
</html>
