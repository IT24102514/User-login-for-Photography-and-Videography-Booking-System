//package
package com.payment.servlet;
//library
import com.payment.dao.UserDAO;
import com.payment.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/update-profile")//URL maping
public class UpdateProfileServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Verify current password
            String currentPassword = request.getParameter("currentPassword");
            if (currentPassword == null || !currentUser.getPassword().equals(currentPassword)) {
                request.setAttribute("error", "Current password is incorrect");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            // Update user information
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            
            if (name == null || name.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
                request.setAttribute("error", "Name and phone number are required");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            currentUser.setName(name.trim());
            currentUser.setPhone(phone.trim());

            // Update photographer-specific fields if applicable
            if ("PHOTOGRAPHER".equals(currentUser.getUserType())) {
                String portfolioLink = request.getParameter("portfolioLink");
                String specialization = request.getParameter("specialization");
                
                if (specialization == null || specialization.trim().isEmpty()) {
                    request.setAttribute("error", "Specialization is required for photographers");
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                    return;
                }
                
                currentUser.setPortfolioLink(portfolioLink != null ? portfolioLink.trim() : null);
                currentUser.setSpecialization(specialization.trim());
            }

            // Update password if provided
            String newPassword = request.getParameter("newPassword");
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                currentUser.setPassword(newPassword.trim());
            }

            // Save updates
            userDAO.updateUser(currentUser);
            
            // Update session
            session.setAttribute("user", currentUser);
            
            // Set success message
            request.setAttribute("success", "Profile updated successfully");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while updating your profile. Please try again.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}
