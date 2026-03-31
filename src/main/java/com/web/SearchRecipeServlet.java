package com.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/SearchRecipeServlet")
public class SearchRecipeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mealmatedb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        System.out.println("🔍 Search Keyword: " + keyword);

        List<Recipe> recipes = new ArrayList<>();

        if (keyword == null || keyword.trim().isEmpty()) {
            request.setAttribute("errorMessage", "⚠️ Please enter a recipe name.");
            request.getRequestDispatcher("searchResults.jsp").forward(request, response);
            return;
        }

        String query = "SELECT recipe_id, recipe_name, ingredients, category, cooking_time, difficulty, instructions, yt_link " +
                       "FROM recipes WHERE recipe_name LIKE ?";

        // ✅ Using try-with-resources for better cleanup
        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement ps = con.prepareStatement(query)) {

            System.out.println("✅ Database connection established successfully!");
            ps.setString(1, "%" + keyword + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Recipe recipe = new Recipe();
                    recipe.setId(rs.getInt("recipe_id"));
                    recipe.setName(rs.getString("recipe_name"));
                    recipe.setIngredients(rs.getString("ingredients"));
                    recipe.setCategory(rs.getString("category"));
                    recipe.setTime(rs.getString("cooking_time"));
                    recipe.setDifficulty(rs.getString("difficulty"));
                    recipe.setInstructions(rs.getString("instructions"));

                    // ✅ Fix YouTube link formatting
                    String youtubeLink = rs.getString("yt_link");
                    if (youtubeLink != null) {
                        if (youtubeLink.contains("youtu.be")) {
                            youtubeLink = youtubeLink.replace("youtu.be/", "www.youtube.com/embed/");
                        }
                        recipe.setYoutubeLink(youtubeLink);
                    } else {
                        recipe.setYoutubeLink(""); // Avoid null values
                    }

                    recipes.add(recipe);
                }
            }

            System.out.println("✅ Recipes found: " + recipes.size());

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "❌ An error occurred while retrieving recipes.");
        }

        if (recipes.isEmpty()) {
            request.setAttribute("errorMessage", "⚠️ No recipes found for '" + keyword + "'.");
        }

        request.setAttribute("recipes", recipes);
        request.getRequestDispatcher("searchResults.jsp").forward(request, response);
    }
}
