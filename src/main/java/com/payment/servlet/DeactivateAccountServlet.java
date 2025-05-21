//package
package com.payment.servlet;
//Library
import com.payment.dao.UserDAO;
import com.payment.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
//URL Maping
@WebServlet("/deactivate-account")
    //URL calling

    //inheritance
public class DeactivateAccountServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    //encapsulation
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
            // Verify password
            String password = request.getParameter("password");
            if (password == null || !currentUser.getPassword().equals(password)) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Incorrect password\"}");
                return;
            }
            // delete crud
            // Deactivate account
            userDAO.deactivateUser(currentUser.getId());
            
            // Invalidate session
            session.invalidate();
            
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true, \"message\": \"Account deactivated successfully\"}");
            
        } catch (Exception e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Failed to deactivate account: " + e.getMessage() + "\"}");
        }
    }
}
