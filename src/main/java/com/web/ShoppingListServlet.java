package com.web;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ShoppingListServlet")
public class ShoppingListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String recipeName = request.getParameter("recipeName");

        List<String> ingredients = new ArrayList<>();
        Map<String, Double> ingredientPrices = new HashMap<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mealmatedb", "root", "root");

            // Fetch ingredients for the given recipe
            String sql = "SELECT ingredients FROM recipes WHERE  recipe_name = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, recipeName);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String[] ingredientArray = rs.getString("ingredients").split(","); // Assuming ingredients are comma-separated
                for (String ingredient : ingredientArray) {
                    ingredient = ingredient.trim();
                    ingredients.add(ingredient);
                    ingredientPrices.put(ingredient, generateRandomPrice());
                }
            } else {
                request.setAttribute("error", "Recipe not found.");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error.");
        }

        request.setAttribute("ingredients", ingredients);
        request.setAttribute("ingredientPrices", ingredientPrices);
        request.getRequestDispatcher("shoppingList.jsp").forward(request, response);
    }

    private double generateRandomPrice() {
    	return (int) (Math.random() * 100 + 20); 
    }
}
