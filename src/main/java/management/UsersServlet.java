package management;
/**
 *
 * @author Julian Edriel
 */

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/register")
public class UsersServlet extends HttpServlet{
    private static final long serialVersionUID = 1L;
    private UsersDao userDao;
    
    @Override
    public void init() {
        userDao = new UsersDao();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repeatPassword = request.getParameter("repeat_password");

        if (!password.equals(repeatPassword)) {
            HttpSession session = request.getSession();
            session.setAttribute("pass_error", "Passwords do not match.");
            
            response.sendRedirect("usersregistration.jsp");
        }

        
        Users user = new Users();
        
        if(userDao.usernameExists(username)){

        HttpSession session = request.getSession();
        session.setAttribute("user_error", "Username already exists.");

        response.sendRedirect("usersregistration.jsp");
        return;
        }

        
        user.setUsername(username);
        user.setFullname(fullname);
        user.setEmail(email);
        
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        user.setPassword(hashedPassword);

        try {
            userDao.registerUser(user);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("book.jsp");
    }
}
