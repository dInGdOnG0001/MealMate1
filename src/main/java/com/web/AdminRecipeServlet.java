package com.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AdminRecipeServlet")
public class AdminRecipeServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mealmatedb", "root", "root")) {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                String ingredients = request.getParameter("ingredients");
                String category = request.getParameter("category");
                int time = Integer.parseInt(request.getParameter("time"));
                String difficulty = request.getParameter("difficulty");
                String instructions = request.getParameter("instructions");
                String youtubeLink = request.getParameter("youtubeLink");

                String sql = "INSERT INTO recipes (recipe_name, ingredients, category, cooking_time, difficulty, instructions, yt_link) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, name);
                stmt.setString(2, ingredients);
                stmt.setString(3, category);
                stmt.setInt(4, time);
                stmt.setString(5, difficulty);
                stmt.setString(6, instructions);
                stmt.setString(7, youtubeLink);
                stmt.executeUpdate();
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String sql = "DELETE FROM recipes WHERE recipe_id=?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, id);
                stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("AdminRecipeServlet");  // Redirect to refresh the page
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Recipe> recipes = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mealmatedb", "root", "root")) {
            String sql = "SELECT * FROM recipes";
            PreparedStatement stmt = conn.prepareStatement(sql);
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
                recipe.setYoutubeLink(rs.getString("yt_link"));
                
                recipes.add(recipe);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("recipes", recipes);
        RequestDispatcher dispatcher = request.getRequestDispatcher("adminDashboard.jsp");
        dispatcher.forward(request, response);
    }
}
