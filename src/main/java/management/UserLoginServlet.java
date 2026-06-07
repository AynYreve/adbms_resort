package management;
/**
 *
 * @author Julian Edriel
 */

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.http.HttpServletRequest;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/LoginServlet")
public class UserLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/olivia_db",
                "root",
                ""
            );

            String sql = "SELECT id, fullname, email, password, role FROM users WHERE username = ?";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);

            rs = stmt.executeQuery();

            if (rs.next()) {

                String storedHash = rs.getString("password");
                String role = rs.getString("role");

                if (BCrypt.checkpw(password, storedHash)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user_id", rs.getInt("id"));
                    session.setAttribute("fullname", rs.getString("fullname"));
                    session.setAttribute("email", rs.getString("email"));
                    
                    if(role.equals("admin")){
                        session.removeAttribute("login_error");
                        session.setAttribute("role", rs.getString("role"));
                        response.sendRedirect("Admin/admin.jsp");
                        
                    } else {
                        session.removeAttribute("login_error");
                        response.sendRedirect("book.jsp?logged=true");
                    }                 
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("login_error", "Incorrect username or password.");
                    response.sendRedirect("book.jsp");
                }

            } else {
                HttpSession session = request.getSession();
                session.setAttribute("login_error", "Incorrect username or password.");
                response.sendRedirect("book.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("login_error", "Server error occurred.");
            response.sendRedirect("book.jsp");
            
        } finally {
            try { if (rs != null) rs.close(); } catch(Exception e) {}
            try { if (stmt != null) stmt.close(); } catch(Exception e) {}
            try { if (conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}
