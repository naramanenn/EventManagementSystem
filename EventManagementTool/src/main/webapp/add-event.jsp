<html>
<head>
    <title>Add New Event</title>
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
            width: 50%;
            margin: 20px auto;
            padding: 20px;
            text-align: left;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
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

        .footer {
            margin-top: 20px;
            padding: 10px;
            border-top: 1px solid #ccc;
        }
    </style>
</head>
<body>

<div class="navbar">
    <a href="index.jsp">Home</a>
    <a href="add-event.jsp" class="active">Add New Event</a>
</div>

<div class="container">
    <h2>Add New Event</h2>

    <form action="AddEventController" method="post">
        <label for="name">Event Name</label>
        <input type="text" id="name" name="name" required>

        <label for="location">Location</label>
        <input type="text" id="location" name="location" required>
        
        <label for="description">Description</label>
        <textarea id="description" name="description" required></textarea>
        
        <label for="date">Date</label>
        <input type="date" id="date" name="date" required>
        
        <label for="event_type">Type</label>
        <select id="event_type" name="event_type" required>
            <option value="Conference">Conference</option>
            <option value="Wedding">Wedding</option>
            <option value="Party">Party</option>
            <option value="Workshop">Workshop</option>
        </select>

        <input type="submit" value="Add Event">
    </form>
</div>

<div class="footer">
    &copy; 2025 Event Management System
</div>

</body>
</html>
