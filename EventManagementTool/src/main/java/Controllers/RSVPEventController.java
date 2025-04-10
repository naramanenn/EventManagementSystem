package Controllers;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RSVPEventController")
public class RSVPEventController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int eventId = Integer.parseInt(request.getParameter("event_id"));
        String userName = request.getParameter("user_name");
        String status = request.getParameter("status");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/events_db", "root", "");

            String query = "INSERT INTO rsvps(event_id, user_name, status) VALUES (?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setInt(1, eventId);
            stmt.setString(2, userName);
            stmt.setString(3, status);
            stmt.executeUpdate();
            con.close();

            response.sendRedirect("index.jsp");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
