package Controllers;
import Models.Event;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SearchEventController")
public class SearchEventController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String eventType = request.getParameter("type");
        String location = request.getParameter("location");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");

        ArrayList<Event> events = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/events_db", "root", "");


            String query = "SELECT e.id, e.name, e.date, e.location, e.description, e.event_type, " +
                           "(SELECT COUNT(*) FROM rsvps WHERE event_id = e.id AND status = 'Attending') AS attendees " +
                           "FROM events e WHERE 1=1";

            if (!name.isEmpty()) {
                query += " AND e.name LIKE ?";
            }
            if (!eventType.isEmpty()) {
                query += " AND e.event_type=?";
            }
            if (!location.isEmpty()) {
                query += " AND e.location LIKE ?";
            }
            if (!startDate.isEmpty() && !endDate.isEmpty()) {
                query += " AND e.date BETWEEN ? AND ?";
            }

            PreparedStatement stmt = con.prepareStatement(query);

            int paramIndex = 1;
            if (!name.isEmpty()) {
                stmt.setString(paramIndex++, "%" + name + "%");
            }
            if (!eventType.isEmpty()) {
                stmt.setString(paramIndex++, eventType);
            }
            if (!location.isEmpty()) {
                stmt.setString(paramIndex++, "%" + location + "%");
            }
            if (!startDate.isEmpty() && !endDate.isEmpty()) {
                stmt.setString(paramIndex++, startDate);
                stmt.setString(paramIndex++, endDate);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Event event = new Event(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("date"),
                        rs.getString("location"),
                        rs.getString("description"),
                        rs.getString("event_type"),
                        rs.getInt("attendees")
                );
                events.add(event);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("events", events);
        RequestDispatcher dispatcher = request.getRequestDispatcher("search-event.jsp");
        dispatcher.forward(request, response);
    }
}
