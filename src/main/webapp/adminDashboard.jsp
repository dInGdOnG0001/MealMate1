<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.web.Recipe" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession adminSession = request.getSession(false);
    if (adminSession == null || adminSession.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<%
    if (request.getAttribute("recipes") == null) {
        response.sendRedirect("AdminRecipeServlet");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - MealMate</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
    <h1 class="text-center">Welcome Admin</h1>
        <h2 class="text-center">Dashboard</h2>

        <!-- Add Recipe Form -->
        <h4>Add New Recipe</h4>
        <form action="AdminRecipeServlet" method="POST">
            <input type="hidden" name="action" value="add">
            
            <div class="form-group">
                <label>Recipe Name:</label>
                <input type="text" name="name" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Ingredients:</label>
                <textarea name="ingredients" class="form-control" required></textarea>
            </div>

            <div class="form-group">
                <label>Category:</label>
                <input type="text" name="category" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Cooking Time (minutes):</label>
                <input type="number" name="time" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Difficulty:</label>
                <select name="difficulty" class="form-control">
                    <option value="Easy">Easy</option>
                    <option value="Medium">Medium</option>
                    <option value="Hard">Hard</option>
                </select>
            </div>

            <div class="form-group">
                <label>Instructions:</label>
                <textarea name="instructions" class="form-control" required></textarea>
            </div>

            <div class="form-group">
                <label>YouTube Link (optional):</label>
                <input type="text" name="youtubeLink" class="form-control">
            </div>

            <button type="submit" class="btn btn-success">Add Recipe</button>
        </form>

        <hr>

        <!-- List of Recipes -->
        <h4>Recipe List</h4>
        <table class="table">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Time</th>
                    <th>Difficulty</th>
                    <th>Instructions</th>
                    <th>YouTube Link</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Recipe> recipes = (List<Recipe>) request.getAttribute("recipes");
                    if (recipes != null && !recipes.isEmpty()) {
                        for (Recipe recipe : recipes) { 
                %>
                <tr>
                    <td><%= recipe.getName() %></td>
                    <td><%= recipe.getCategory() %></td>
                    <td><%= recipe.getTime() %> min</td>
                    <td><%= recipe.getDifficulty() %></td>
                    <td><%= recipe.getInstructions() %></td>
                    <td>
                        <% if (recipe.getYoutubeLink() != null && !recipe.getYoutubeLink().isEmpty()) { %>
                            <a href="<%= recipe.getYoutubeLink() %>" target="_blank">Watch Video</a>
                        <% } else { %>
                            No Video
                        <% } %>
                    </td>
                    <td>
                        <a href="updateRecipe.jsp?id=<%= recipe.getId() %>" class="btn btn-warning">Update</a>
                        <a href="AdminRecipeServlet?action=delete&id=<%= recipe.getId() %>" class="btn btn-danger">Delete</a>
                    </td>
                </tr>
                <% 
                        } 
                    } else { 
                %>
                <tr><td colspan="7">No recipes found.</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
