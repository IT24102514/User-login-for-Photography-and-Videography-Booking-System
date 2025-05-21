//package
package com.payment.servlet;

import com.payment.dao.UserDAO;
import com.payment.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate passwords match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        // Validate password requirements
        if (!newPassword.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")) {
            request.setAttribute("error", "Password must be at least 8 characters long and contain both letters and numbers");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        User user = userDAO.getUserByEmail(email);

        if (user != null && user.getPhone().equals(phone)) {
            // Update password
            user.setPassword(newPassword);
            userDAO.updateUser(user);
            
            request.setAttribute("message", "Password has been reset successfully. You can now login with your new password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "No account found with the provided email and phone number");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        }
    }
}
