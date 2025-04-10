<%@ page import="java.sql.*" %>
<%@ page import="Models.Event" %>

<%
    int eventId = Integer.parseInt(request.getParameter("id"));
    String name = "", date = "", location = "", description = "", eventType = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/events_db", "root", "");

        String query = "SELECT * FROM events WHERE id=?";
        PreparedStatement stmt = con.prepareStatement(query);
        stmt.setInt(1, eventId);
        ResultSet rs = stmt.executeQuery();

        if(rs.next()) {
            name = rs.getString("name");
            date = rs.getString("date");
            location = rs.getString("location");
            description = rs.getString("description");
            eventType = rs.getString("event_type");
        }
        con.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
<html>
<head>
    <title>Edit Event</title>
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
    
    .link{
    	color: blue;
    	text-decoration: none;
    	cursor: pointer;
    }
    
    .link:hover{
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
    border: 1px solid #333
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
    <h1>Edit Event</h1>
    <form action="EditEventController" method="post">
        <input type="hidden" name="id" value="<%= eventId %>">
        Name: <input type="text" name="name" value="<%= name %>"><br><br>
        Date: <input type="date" name="date" value="<%= date %>"><br><br>
        Location: <input type="text" name="location" value="<%= location %>"><br><br>
        Description: <textarea name="description"><%= description %></textarea><br><br>
        Type: 
        <select name="event_type">
            <option value="Conference" <%= eventType.equals("Conference") ? "selected" : "" %>>Conference</option>
            <option value="Wedding" <%= eventType.equals("Wedding") ? "selected" : "" %>>Wedding</option>
            <option value="Workshop" <%= eventType.equals("Workshop") ? "selected" : "" %>>Workshop</option>
            <option value="Party" <%= eventType.equals("Party") ? "selected" : "" %>>Party</option>
        </select><br><br>
        <input type="submit" value="Update Event">
    </form>
    </div>
    <div class="footer">
    &copy; 2025 Event Management System
</div>
</body>
</html>
