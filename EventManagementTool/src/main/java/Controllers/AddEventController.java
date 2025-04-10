package Controllers;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddEventController")
public class AddEventController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String date = request.getParameter("date");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String eventType = request.getParameter("event_type");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/events_db", "root", "");
            
            String query = "INSERT INTO events(name, date, location, description, event_type) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, name);
            stmt.setString(2, date);
            stmt.setString(3, location);
            stmt.setString(4, description);
            stmt.setString(5, eventType);
            stmt.executeUpdate();
            con.close();
            
            response.sendRedirect("index.jsp");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
