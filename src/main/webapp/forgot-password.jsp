<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
            overflow: hidden;
            transition: all 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
        }
        .card-header {
            background: linear-gradient(45deg, #1a237e, #283593);
            color: white;
            padding: 20px;
            border-bottom: none;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px;
            border: 2px solid #e0e0e0;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #764ba2;
            box-shadow: 0 0 0 0.2rem rgba(118,75,162,0.25);
        }
        .btn-primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
        .form-label {
            font-weight: 600;
            color: #424242;
            margin-bottom: 8px;
        }
        .alert {
            border-radius: 10px;
            border: none;
            margin-bottom: 20px;
        }
        .alert-danger {
            background-color: #ffebee;
            color: #c62828;
        }
        .alert-info {
            background-color: #e3f2fd;
            color: #1565c0;
        }
        .back-to-login {
            color: #764ba2;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .back-to-login:hover {
            color: #667eea;
            text-decoration: none;
        }
        .password-input-group {
            position: relative;
        }
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #757575;
        }
        .form-text {
            color: #757575;
            font-size: 0.85rem;
            margin-top: 5px;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fade-in {
            animation: fadeIn 0.5s ease-out;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card animate-fade-in">
                    <div class="card-header">
                        <h3 class="text-center mb-0"><i class="fas fa-lock me-2"></i>Reset Password</h3>
                    </div>
                    <div class="card-body p-4">
                        <% if (request.getAttribute("message") != null) { %>
                            <div class="alert alert-info animate-fade-in">
                                <i class="fas fa-info-circle me-2"></i>
                                <%= request.getAttribute("message") %>
                            </div>
                        <% } %>
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger animate-fade-in">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        <form action="forgot-password" method="post" onsubmit="return validateForm()" class="needs-validation" novalidate>
                            <div class="mb-4">
                                <label for="email" class="form-label"><i class="fas fa-envelope me-2"></i>Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                                <div class="invalid-feedback">Please enter a valid email address.</div>
                            </div>
                            <div class="mb-4">
                                <label for="phone" class="form-label"><i class="fas fa-phone me-2"></i>Phone Number</label>
                                <input type="tel" class="form-control" id="phone" name="phone" required 
                                       pattern="[0-9]{10}">
                                <div class="invalid-feedback">Please enter a valid 10-digit phone number.</div>
                                <small class="form-text">Enter the phone number associated with your account</small>
                            </div>
                            <div class="mb-4">
                                <label for="newPassword" class="form-label"><i class="fas fa-key me-2"></i>New Password</label>
                                <div class="password-input-group">
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" required 
                                           minlength="8" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$">
                                    <i class="fas fa-eye password-toggle" onclick="togglePassword('newPassword')"></i>
                                </div>
                                <div class="invalid-feedback">Password must be at least 8 characters with letters and numbers.</div>
                                <small class="form-text">Must be at least 8 characters with letters and numbers</small>
                            </div>
                            <div class="mb-4">
                                <label for="confirmPassword" class="form-label"><i class="fas fa-key me-2"></i>Confirm Password</label>
                                <div class="password-input-group">
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                    <i class="fas fa-eye password-toggle" onclick="togglePassword('confirmPassword')"></i>
                                </div>
                                <div class="invalid-feedback">Passwords do not match.</div>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 mb-3">
                                <i class="fas fa-sync-alt me-2"></i>Reset Password
                            </button>
                            <div class="text-center">
                                <a href="login.jsp" class="back-to-login">
                                    <i class="fas fa-arrow-left me-2"></i>Back to Login
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    // Form validation
    (function () {
        'use strict'
        var forms = document.querySelectorAll('.needs-validation')
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()

    // Password validation and matching
    function validateForm() {
        var password = document.getElementById("newPassword");
        var confirmPassword = document.getElementById("confirmPassword");
        var isValid = true;

        if (!password.value.match(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/)) {
            password.setCustomValidity("Password must be at least 8 characters with letters and numbers");
            isValid = false;
        } else {
            password.setCustomValidity("");
        }

        if (password.value !== confirmPassword.value) {
            confirmPassword.setCustomValidity("Passwords do not match");
            isValid = false;
        } else {
            confirmPassword.setCustomValidity("");
        }

        return isValid;
    }

    // Toggle password visibility
    function togglePassword(inputId) {
        var input = document.getElementById(inputId);
        var icon = input.nextElementSibling;
        
        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            input.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    }
    </script>
</body>
</html>
