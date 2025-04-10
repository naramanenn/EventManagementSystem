<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>

<html>
<head>
    <title>Event Management System</title>
  
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
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        width: 50%;
        margin: auto;
    }

    label {
        font-weight: bold;
        margin: 10px 0 5px;
        display: block;
    }

    input, select {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 3px;
        font-size: 16px;
    }

    input[type="submit"] {
        background-color: #ddd;
        border: none;
        padding: 10px;
        font-size: 16px;
        cursor: pointer;
        width: 100%;
    }

    input[type="submit"]:hover {
        background-color: #bbb;
    }

    .date-range {
        display: flex;
        justify-content: space-between;
        width: 100%;
    }

    .date-range input {
        width: 200px;
    }
    </style>
</head>
<body>

<div class="navbar">
    <a href="index.jsp">Home</a>
    <a href="add-event.jsp">Add New Event</a>
</div>

<div class="container">
    <h1>Event Management System</h1>
    <p>Effortlessly Plan, Organize, and RSVP for Events!</p>

    <h2>Search Events</h2>
    <form action="index.jsp" method="get">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">

        <label for="event_type">Event Type:</label>
        <select id="event_type" name="event_type">
            <option value="">-- Select --</option>
            <option value="Conference">Conference</option>
            <option value="Wedding">Wedding</option>
            <option value="Workshop">Workshop</option>
            <option value="Party">Party</option>
        </select>

        <label for="location">Location:</label>
        <input type="text" id="location" name="location" value="<%= request.getParameter("location") != null ? request.getParameter("location") : "" %>">

        <div class="date-range">
            <div>
                <label for="start_date">Date From:</label>
                <input type="date" id="start_date" name="start_date" value="<%= request.getParameter("start_date") != null ? request.getParameter("start_date") : "" %>">
            </div>
            <div>
                <label for="end_date">To:</label>
                <input type="date" id="end_date" name="end_date" value="<%= request.getParameter("end_date") != null ? request.getParameter("end_date") : "" %>">
            </div>
        </div>

        <input type="submit" value="Search">
    </form>

    <h2>All Events</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Date</th>
            <th>Location</th>
            <th>Type</th>
            <th>Actions</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/events_db", "root", "");
                String query = "SELECT * FROM events WHERE date >= CURDATE()";
                
                String name = request.getParameter("name");
                String eventType = request.getParameter("event_type");
                String location = request.getParameter("location");
                String startDate = request.getParameter("start_date");
                String endDate = request.getParameter("end_date");

                if (name != null && !name.isEmpty()) {
                    query += " AND name LIKE '%" + name + "%'";
                }
                if (eventType != null && !eventType.isEmpty()) {
                    query += " AND event_type = '" + eventType + "'";
                }
                if (location != null && !location.isEmpty()) {
                    query += " AND location LIKE '%" + location + "%'";
                }
                if (startDate != null && !startDate.isEmpty()) {
                    query += " AND date >= '" + startDate + "'";
                }
                if (endDate != null && !endDate.isEmpty()) {
                    query += " AND date <= '" + endDate + "'";
                }

                query += " ORDER BY date ASC";

                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while(rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("date") %></td>
            <td><%= rs.getString("location") %></td>
            <td><%= rs.getString("event_type") %></td>
            <td>
                <a class="link" href="edit-event.jsp?id=<%= rs.getInt("id") %>">Edit</a> |
                <a class="link" onclick="confirmDelete(<%= rs.getInt("id") %>)">Delete</a> |
                <a class="link" href="rsvp-event.jsp?id=<%= rs.getInt("id") %>">RSVP</a>
            </td>
        </tr>
        <%
                }
                con.close();
            } catch(Exception e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            }
        %>
    </table>
</div>

<div class="footer">
    &copy; 2025 Event Management System.
</div>
    <script>
        function confirmDelete(id) {
            if(confirm("Are you sure?")) {
                window.location.href = "DeleteEventController?id=" + id;
            }
        }
    </script>
</body>
</html>
