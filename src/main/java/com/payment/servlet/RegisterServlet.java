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
import java.io.IOException;
//URL maping
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        // Check if user already exists
        if (userDAO.getUserByEmail(email) != null) {
            request.setAttribute("error", "Email already registered");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);
        user.setUserType(userType);

        // Additional fields for photographers
        if ("PHOTOGRAPHER".equals(userType)) {
            user.setPortfolioLink(request.getParameter("portfolioLink"));
            user.setSpecialization(request.getParameter("specialization"));
            user.setAvailability(request.getParameter("availability"));
        }

        userDAO.saveUser(user);
        response.sendRedirect("login.jsp");
    }
}
