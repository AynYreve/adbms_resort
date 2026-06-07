package management;

/**
 *
 * @author Julian Edriel
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/processBooking")
public class UserBooking extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String fullname = (String) session.getAttribute("fullname");
        String email = (String) session.getAttribute("email");

        String roomType = request.getParameter("roomType");
        String adultCount = request.getParameter("adultCount");
        String childrenCount = request.getParameter("childrenCount");

        String bookingMonth = request.getParameter("booking_month");
        String bookingDay = request.getParameter("booking_day");

        String bookingTime = request.getParameter("booking_time");
        String bookingPeriod = request.getParameter("booking_period");

        String fullBookingTime = bookingTime + " " + bookingPeriod;

        Connection conn = null;
        PreparedStatement pst = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(
                "jdbc:mysql://127.0.0.1:3306/olivia_db",
                "root",
                ""
            );

            String sql = "INSERT INTO booking " + "(guestname, email, room_type, adult_count, children_count, reserved_month, reserved_day, reserved_time) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            pst = conn.prepareStatement(sql);

            pst.setString(1, fullname);
            pst.setString(2, email);
            pst.setString(3, roomType);
            pst.setInt(4, Integer.parseInt(adultCount));
            pst.setInt(5, Integer.parseInt(childrenCount));
            pst.setString(6, bookingMonth);
            pst.setInt(7, Integer.parseInt(bookingDay));
            pst.setString(8, fullBookingTime);

            pst.executeUpdate();

            response.sendRedirect("booking/process_booking.jsp");

        }
        catch(Exception e) {

            response.getWriter().println(e);

        }
        finally {

            try {

                if(pst != null) pst.close();
                if(conn != null) conn.close();

            }
            catch(Exception e) {
                e.printStackTrace();
            }
        }
    }
}
