<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.payment.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"PHOTOGRAPHER".equals(user.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String success = (String) session.getAttribute("success");
    String error = (String) session.getAttribute("error");
    session.removeAttribute("success");
    session.removeAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Photographer Dashboard - Photography Service</title>
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
            padding: 2rem 1.5rem;
            position: fixed;
            width: inherit;
            max-width: inherit;
        }

        .main-content {
            margin-left: auto;
            padding: 2.5rem;
        }

        .profile-section {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border-radius: 1.5rem;
            padding: 2.5rem;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
            color: white;
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
            margin-bottom: 1.5rem;
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

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title i {
            color: var(--primary-color);
        }

        .alert {
            border-radius: 0.75rem;
            border: none;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 sidebar">
                <div class="text-center mb-4">
                    <h5 class="text-white mb-0">Photography Service</h5>
                </div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="photographer-dashboard.jsp">
                            <i class="fas fa-home"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="profile.jsp">
                            <i class="fas fa-user"></i>Profile
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout">
                            <i class="fas fa-sign-out-alt"></i>Logout
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <% if (success != null) { %>
                    <div class="alert alert-success" role="alert">
                        <i class="fas fa-check-circle me-2"></i><%= success %>
                    </div>
                <% } %>
                <% if (error != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i><%= error %>
                    </div>
                <% } %>

                <!-- Profile Header -->
                <div class="profile-section">
                    <div class="row align-items-center">
                        <div class="col">
                            <p class="welcome-text">Welcome back,</p>
                            <h3 class="user-name"><%= user.getName() %></h3>
                            <p class="mb-0 opacity-75">Manage your schedule and bookings</p>
                        </div>
                        <div class="col-auto">
                            <button class="btn btn-light btn-custom" data-bs-toggle="modal" data-bs-target="#availabilityModal">
                                <i class="fas fa-calendar-alt me-2"></i>Update Availability
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Stats Row -->
                <div class="row mb-4">
                    <div class="col-md-4">
                        <div class="stat-card">
                            <div class="stat-icon icon-primary">
                                <i class="fas fa-calendar-check"></i>
                            </div>
                            <h6 class="stat-label">Upcoming Sessions</h6>
                            <h3 class="stat-value">5</h3>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card">
                            <div class="stat-icon icon-success">
                                <i class="fas fa-users"></i>
                            </div>
                            <h6 class="stat-label">Total Clients</h6>
                            <h3 class="stat-value">28</h3>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card">
                            <div class="stat-icon icon-warning">
                                <i class="fas fa-star"></i>
                            </div>
                            <h6 class="stat-label">Rating</h6>
                            <h3 class="stat-value">4.8</h3>
                        </div>
                    </div>
                </div>

                <!-- Availability Section -->
                <div class="booking-list">
                    <h5 class="section-title">
                        <i class="fas fa-clock"></i>
                        Current Availability
                    </h5>
                    <p class="mb-3"><%= user.getAvailability() != null ? user.getAvailability() : "No availability set" %></p>
                </div>

                <!-- Upcoming Bookings -->
                <div class="booking-list">
                    <h5 class="section-title">
                        <i class="fas fa-calendar"></i>
                        Upcoming Bookings
                    </h5>
                    <div class="booking-item">
                        <div class="row align-items-center">
                            <div class="col">
                                <h6 class="mb-1">Wedding Photography</h6>
                                <p class="text-muted mb-0">
                                    <i class="fas fa-user me-2"></i>John & Sarah
                                    <i class="fas fa-calendar ms-3 me-2"></i>May 15, 2025
                                </p>
                            </div>
                            <div class="col-auto">
                                <span class="badge bg-primary">Confirmed</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Availability Modal -->
    <div class="modal fade" id="availabilityModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-calendar-alt me-2"></i>Update Availability
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="update-availability" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="availability" class="form-label">Availability Details</label>
                            <textarea class="form-control" id="availability" name="availability" rows="4" required
                                placeholder="Describe your available hours, days, or any specific scheduling preferences"><%= user.getAvailability() != null ? user.getAvailability() : "" %></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
