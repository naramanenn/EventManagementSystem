<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

<%
    String eventId = request.getParameter("id");
    String eventName = "";
    String eventLocation = "";
    String eventDate = "";
    ArrayList<String[]> rsvpList = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/events_db", "root", "");

        String query = "SELECT name, date, location FROM events WHERE id=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(eventId));
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            eventName = rs.getString("name");
            eventDate = rs.getString("date");
            eventLocation = rs.getString("location");
        }

        String rsvpQuery = "SELECT user_name, status FROM rsvps WHERE event_id=?";
        PreparedStatement ps2 = con.prepareStatement(rsvpQuery);
        ps2.setInt(1, Integer.parseInt(eventId));
        ResultSet rs2 = ps2.executeQuery();

        while (rs2.next()) {
            rsvpList.add(new String[]{rs2.getString("user_name"), rs2.getString("status")});
        }

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<html>
<head>
    <title>RSVP for <%= eventName %></title>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        .navbar {
            padding: 10px 0;
            border-bottom: 1px solid #ccc;
        }

        .navbar a {
            text-decoration: none;
            padding: 10px 15px;
            display: inline-block;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 8px;
            border: 1px solid #000;
            text-align: center;
        }

        th {
            font-weight: bold;
        }

        .footer {
            margin-top: 20px;
            padding: 10px;
            border-top: 1px solid #ccc;
        }
        
        .link {
            color: blue;
            text-decoration: none;
            cursor: pointer;
        }

        .link:hover {
            text-decoration: underline;
        }

        form {
            width: 50%;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-align: left;
        }

        label {
            display: block;
            font-weight: bold;
            margin: 10px 0 5px;
        }

        input, textarea, select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            font-size: 16px;
        }

        textarea {
            height: 80px;
            resize: vertical;
        }

        input[type="submit"] {
            border: 1px solid #333;
            padding: 10px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #bbb;
        }
    </style>
</head>
<body>

<div class="navbar">
    <a href="index.jsp">Home</a>
    <a href="add-event.jsp">Add New Event</a>
</div>

<div class="container">
    <h1>RSVP</h1>
    <h3><%= eventName %></h3>
    <p>(<%= eventDate %>)</p>
    <p>(<%= eventLocation %>)</p>
    <br>

    <h2>Submit a new RSVP</h2>
    <form action="RSVPEventController" method="post">
        <label>Your Name:</label>
        <input type="text" name="user_name" required>

        <label>Status:</label>
        <select name="status">
            <option value="Attending">Attending</option>
            <option value="Not Attending">Not Attending</option>
        </select>

        <input type="hidden" name="event_id" value="<%= eventId %>">
        <input type="submit" value="Submit RSVP">
    </form>

    <h2>Attendee List</h2>
    <table>
        <tr>
            <th>Name</th>
            <th>Status</th>
        </tr>
        <% if (rsvpList.size() > 0) { %>
            <% for (String[] rsvp : rsvpList) { %>
            <tr>
                <td><%= rsvp[0] %></td>
                <td><%= rsvp[1] %></td>
            </tr>
            <% } %>
        <% } else { %>
            <tr>
                <td colspan="2" style="text-align:center; padding: 15px;">
                    No RSVPs found for this event.
                </td>
            </tr>
        <% } %>
    </table>
</div>

<div class="footer">
    &copy; 2025 Event Management System
</div>

</body>
</html>
