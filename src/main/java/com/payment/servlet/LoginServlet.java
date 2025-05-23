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
//URL Maping
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
//encapsulation
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (userDAO.validateCredentials(email, password)) {
            User user = userDAO.getUserByEmail(email);
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Redirect based on user type
            if ("PHOTOGRAPHER".equals(user.getUserType())) {
                response.sendRedirect("photographer-dashboard.jsp");
            } else {
                response.sendRedirect("client-dashboard.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
