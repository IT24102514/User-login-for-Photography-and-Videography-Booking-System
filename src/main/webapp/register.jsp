<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Home tutor  Service</title>
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            color: var(--text-primary);
            padding: 2rem 0;
        }

        .register-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 2rem;
        }

        .card {
            border: none;
            border-radius: 1.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            background: var(--card-bg);
            overflow: hidden;
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            border: none;
            padding: 2.5rem 2rem;
            position: relative;
            overflow: hidden;
        }

        .card-header::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            transform: translate(30%, -30%);
        }

        .card-header h3 {
            font-weight: 700;
            font-size: 1.875rem;
            margin-bottom: 0.5rem;
            position: relative;
        }

        .card-header p {
            opacity: 0.9;
            font-size: 1rem;
            position: relative;
            margin: 0;
        }

        .card-body {
            padding: 2rem;
        }

        .form-label {
            color: var(--text-primary);
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border-radius: 0.75rem;
            padding: 0.75rem 1rem;
            border: 1px solid rgba(0,0,0,0.1);
            font-size: 1rem;
            background-color: var(--background);
            color: var(--text-primary);
            transition: all 0.2s ease;
        }

        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
            border-color: var(--primary-color);
        }

        .input-group {
            margin-bottom: 1.5rem;
        }

        .input-group-text {
            background: var(--background);
            border: 1px solid rgba(0,0,0,0.1);
            border-right: none;
            border-radius: 0.75rem 0 0 0.75rem;
            padding: 0.75rem 1rem;
            color: var(--text-secondary);
        }

        .input-group .form-control {
            border-left: none;
            border-radius: 0 0.75rem 0.75rem 0;
        }

        .btn-register {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border: none;
            border-radius: 0.75rem;
            padding: 0.875rem;
            font-weight: 600;
            font-size: 1rem;
            color: white;
            width: 100%;
            transition: all 0.3s ease;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.2);
        }

        .alert {
            border-radius: 0.75rem;
            border: none;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
        }

        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
        }

        .login-link a:hover {
            background: rgba(79, 70, 229, 0.1);
            color: var(--primary-dark);
        }

        #photographerFields {
            transition: all 0.3s ease;
            opacity: 0;
            max-height: 0;
            overflow: hidden;
        }

        #photographerFields.show {
            opacity: 1;
            max-height: 1000px;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container">
            <div class="card">
                <div class="card-header text-center">
                    <h3>Create Account</h3>
                    <p>Register Our Home Tutor</p>
                </div>
                <div class="card-body">
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle"></i>
                            <span><%= request.getAttribute("error") %></span>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>

                    <form action="register" method="post">
                        <div class="mb-3">
                            <label for="userType" class="form-label">Register as:</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-user-tag"></i>
                                </span>
                                <select class="form-select" id="userType" name="userType" onchange="togglePhotographerFields()">
                                    <option value="CLIENT">Client</option>
                                    <option value="PHOTOGRAPHER">Photographer/Videographer</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-user"></i>
                                </span>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-envelope"></i>
                                </span>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-phone"></i>
                                </span>
                                <input type="tel" class="form-control" id="phone" name="phone" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-lock"></i>
                                </span>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                        </div>
                        
                        <!-- Photographer specific fields -->
                        <div id="photographerFields">
                            <div class="mb-3">
                                <label for="portfolioLink" class="form-label">Portfolio Link</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-link"></i>
                                    </span>
                                    <input type="url" class="form-control" id="portfolioLink" name="portfolioLink">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="specialization" class="form-label">Specialization</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-camera"></i>
                                    </span>
                                    <select class="form-select" id="specialization" name="specialization">
                                        <option value="PHOTO">Photography</option>
                                        <option value="VIDEO">Videography</option>
                                        <option value="BOTH">Both</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="availability" class="form-label">Availability</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-calendar"></i>
                                    </span>
                                    <textarea class="form-control" id="availability" name="availability" rows="3"
                                        placeholder="Describe your available hours and days"></textarea>
                                </div>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-register">Create Account</button>
                    </form>

                    <div class="login-link">
                        Already have an account? <a href="login.jsp">
                            <i class="fas fa-sign-in-alt me-1"></i>Login here
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function togglePhotographerFields() {
            const userType = document.getElementById('userType').value;
            const photographerFields = document.getElementById('photographerFields');
            if (userType === 'PHOTOGRAPHER') {
                photographerFields.classList.add('show');
            } else {
                photographerFields.classList.remove('show');
            }
        }
    </script>
</body>
</html>
