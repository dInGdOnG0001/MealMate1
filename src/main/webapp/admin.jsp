<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String adminUsername = (String) session.getAttribute("adminUsername");

if (adminUsername == null) {
    response.sendRedirect("adminLogin.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel - MealMate</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background:#000 000 000;
            background-size: cover;
            color: #fff;
            text-align: center;
            padding-top: 100px;
        }
        .container {
            background: rgba(0, 0, 0, 0.8);
            padding: 40px;
            border-radius: 10px;
            max-width: 500px;
            margin: auto;
        }
        h2 {
            color: #FFD700;
        }
        .btn {
            font-size: 18px;
            padding: 12px;
            margin-top: 15px;
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome, Admin!</h2>
        <p>Choose an option below:</p>
        <a href="recipeManagement.jsp" class="btn btn-warning">Recipe Management</a>
        <br><br>
        <a href="logout.jsp" class="btn btn-danger">Logout</a>
    </div>
</body>
</html>
