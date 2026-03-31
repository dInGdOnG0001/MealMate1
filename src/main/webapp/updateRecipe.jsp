<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.web.Recipe" %>
<%@ page import="java.sql.*" %>

<%
    String recipeId = request.getParameter("id");
    Recipe recipe = null;

    if (recipeId != null) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mealmatedb", "root", "root")) {
            String sql = "SELECT * FROM recipes WHERE recipe_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(recipeId));
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                recipe = new Recipe();
                recipe.setId(rs.getInt("recipe_id"));
                recipe.setName(rs.getString("recipe_name"));
                recipe.setIngredients(rs.getString("ingredients"));
                recipe.setCategory(rs.getString("category"));
                recipe.setTime(rs.getString("cooking_time"));
                recipe.setDifficulty(rs.getString("difficulty"));
                recipe.setInstructions(rs.getString("instructions"));
                recipe.setYoutubeLink(rs.getString("yt_link"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    if (recipe == null) {
        response.sendRedirect("adminDashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Recipe - MealMate</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Update Recipe</h2>
        <form action="UpdateRecipeServlet" method="POST">
            <input type="hidden" name="id" value="<%= recipe.getId() %>">

            <div class="form-group">
                <label>Recipe Name:</label>
                <input type="text" name="name" class="form-control" value="<%= recipe.getName() %>" required>
            </div>

            <div class="form-group">
                <label>Ingredients:</label>
                <textarea name="ingredients" class="form-control" required><%= recipe.getIngredients() %></textarea>
            </div>

            <div class="form-group">
                <label>Category:</label>
                <input type="text" name="category" class="form-control" value="<%= recipe.getCategory() %>" required>
            </div>

            <div class="form-group">
                <label>Cooking Time (minutes):</label>
                <input type="number" name="time" class="form-control" value="<%= recipe.getTime() %>" required>
            </div>

            <div class="form-group">
                <label>Difficulty:</label>
                <select name="difficulty" class="form-control">
                    <option value="Easy" <%= recipe.getDifficulty().equals("Easy") ? "selected" : "" %>>Easy</option>
                    <option value="Medium" <%= recipe.getDifficulty().equals("Medium") ? "selected" : "" %>>Medium</option>
                    <option value="Hard" <%= recipe.getDifficulty().equals("Hard") ? "selected" : "" %>>Hard</option>
                </select>
            </div>

            <div class="form-group">
                <label>Instructions:</label>
                <textarea name="instructions" class="form-control" required><%= recipe.getInstructions() %></textarea>
            </div>

            <div class="form-group">
                <label>YouTube Link:</label>
                <input type="text" name="youtubeLink" class="form-control" value="<%= recipe.getYoutubeLink() %>">
            </div>

            <button type="submit" class="btn btn-primary">Update Recipe</button>
            <a href="adminDashboard.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>
