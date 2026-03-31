package com.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/RecommendationServlet")
public class RecommendationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ingredient = request.getParameter("ingredient");
        String category = request.getParameter("category");
        String difficulty = request.getParameter("difficulty");
        String timeStr = request.getParameter("time");

        int maxTime = (timeStr != null && !timeStr.trim().isEmpty()) ? Integer.parseInt(timeStr) : 120;
        List<Recipe> recipes = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load JDBC driver

            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mealmatedb", "root", "root")) {
                StringBuilder query = new StringBuilder("SELECT * FROM recipes WHERE cooking_time <= ?");
                List<Object> params = new ArrayList<>();
                params.add(maxTime);

                if (ingredient != null && !ingredient.trim().isEmpty()) {
                    query.append(" AND ingredients LIKE ?");
                    params.add("%" + ingredient.trim() + "%");
                }
                if (category != null && !category.trim().isEmpty()) {
                    query.append(" AND category = ?");
                    params.add(category.trim());
                }
                if (difficulty != null && !difficulty.trim().isEmpty()) {
                    query.append(" AND difficulty = ?");
                    params.add(difficulty.trim());
                }

                PreparedStatement stmt = conn.prepareStatement(query.toString());
                for (int i = 0; i < params.size(); i++) {
                    if (params.get(i) instanceof Integer) {
                        stmt.setInt(i + 1, (int) params.get(i));
                    } else {
                        stmt.setString(i + 1, (String) params.get(i));
                    }
                }

                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Recipe recipe = new Recipe();
                    recipe.setId(rs.getInt("recipe_id"));
                    recipe.setName(rs.getString("recipe_name"));
                    recipe.setIngredients(rs.getString("ingredients"));
                    recipe.setCategory(rs.getString("category"));
                    recipe.setTime(rs.getString("cooking_time"));
                    recipe.setDifficulty(rs.getString("difficulty"));
                    recipe.setInstructions(rs.getString("instructions"));
                    recipe.setYoutubeLink(formatYouTubeLink(rs.getString("yt_link")));

                    recipes.add(recipe);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("recommendedRecipes", recipes);
        RequestDispatcher dispatcher = request.getRequestDispatcher("recommendation.jsp");
        dispatcher.forward(request, response);
    }

    private String formatYouTubeLink(String youtubeLink) {
        if (youtubeLink == null || youtubeLink.isEmpty()) return null;
        if (youtubeLink.contains("watch?v=")) {
            return youtubeLink.replace("watch?v=", "embed/");
        } else if (youtubeLink.contains("youtu.be/")) {
            return youtubeLink.replace("youtu.be/", "www.youtube.com/embed/");
        }
        return youtubeLink;
    }
}
