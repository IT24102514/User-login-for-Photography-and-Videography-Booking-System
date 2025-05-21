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
//URL maping
@WebServlet("/update-availability")
public class UpdateAvailabilityServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
//abstruction
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null || !"PHOTOGRAPHER".equals(currentUser.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String availability = request.getParameter("availability");
            if (availability == null || availability.trim().isEmpty()) {
                session.setAttribute("error", "Availability cannot be empty");
                response.sendRedirect("photographer-dashboard.jsp");
                return;
            }

            // Update user availability
            currentUser.setAvailability(availability.trim());
            userDAO.updateUser(currentUser);
            
            // Update session with new user data
            session.setAttribute("user", currentUser);
            
            // Set success message
            session.setAttribute("success", "Availability updated successfully");
            
        } catch (Exception e) {
            session.setAttribute("error", "Failed to update availability: " + e.getMessage());
        }
        
        response.sendRedirect("photographer-dashboard.jsp");
    }
}
