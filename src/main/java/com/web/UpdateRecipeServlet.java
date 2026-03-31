package com.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/UpdateRecipeServlet")
public class UpdateRecipeServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String ingredients = request.getParameter("ingredients");
        String category = request.getParameter("category");
        int time = Integer.parseInt(request.getParameter("time"));
        String difficulty = request.getParameter("difficulty");
        String instructions = request.getParameter("instructions");
        String youtubeLink = request.getParameter("youtubeLink");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mealmatedb", "root", "root")) {
            String sql = "UPDATE recipes SET recipe_name=?, ingredients=?, category=?, cooking_time=?, difficulty=?, instructions=?, yt_link=? WHERE recipe_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, ingredients);
            stmt.setString(3, category);
            stmt.setInt(4, time);
            stmt.setString(5, difficulty);
            stmt.setString(6, instructions);
            stmt.setString(7, youtubeLink);
            stmt.setInt(8, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminDashboard.jsp");
    }
}
