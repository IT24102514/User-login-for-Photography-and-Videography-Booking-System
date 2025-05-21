<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Photography Service</title>
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
            height: 100vh;
            display: flex;
            align-items: center;
            color: var(--text-primary);
        }

        .login-container {
            max-width: 420px;
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
        }

        .card-body {
            padding: 2rem;
        }

        .form-control {
            border-radius: 0.75rem;
            padding: 0.75rem 1rem;
            border: 1px solid rgba(0,0,0,0.1);
            font-size: 1rem;
            background-color: var(--background);
            color: var(--text-primary);
            transition: all 0.2s ease;
        }

        .form-control:focus {
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

        .btn-login {
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

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.2);
        }

        .divider {
            height: 1px;
            background: rgba(0,0,0,0.1);
            margin: 1.5rem 0;
        }

        .links {
            text-align: center;
            font-size: 0.875rem;
        }

        .links a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
        }

        .links a:hover {
            background: rgba(79, 70, 229, 0.1);
            color: var(--primary-dark);
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

        .btn-close {
            opacity: 0.5;
            transition: all 0.2s ease;
        }

        .btn-close:hover {
            opacity: 1;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="card">
                <div class="card-header text-center">
                    <h3>Welcome Back</h3>
                    <p>Sign in to your account</p>
                </div>
                <div class="card-body">
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle"></i>
                            <span><%= request.getAttribute("error") %></span>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>
                    
                    <form action="login" method="post">
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-envelope"></i>
                            </span>
                            <input type="email" class="form-control" id="email" name="email" 
                                   placeholder="Email address" required autofocus>
                        </div>
                        
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-lock"></i>
                            </span>
                            <input type="password" class="form-control" id="password" name="password" 
                                   placeholder="Password" required>
                        </div>
                        
                        <button type="submit" class="btn btn-login">
                            Sign In
                        </button>
                    </form>

                    <div class="divider"></div>
                    
                    <div class="links">
                        <a href="forgot-password.jsp">
                            <i class="fas fa-key me-2"></i>Forgot Password?
                        </a>
                        <a href="register.jsp">
                            <i class="fas fa-user-plus me-2"></i>Create New Account
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
