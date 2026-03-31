package com.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LikePostServlet")
public class LikePostServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int postId = Integer.parseInt(request.getParameter("post_id"));

        String dbURL = "jdbc:mysql://localhost:3306/mealmatedb";
        String dbUser = "root";
        String dbPass = "root";

        try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
            // Check if the user already liked the post
            String checkQuery = "SELECT COUNT(*) FROM community_likes WHERE post_id = ? AND username = ?";
            PreparedStatement checkStmt = con.prepareStatement(checkQuery);
            checkStmt.setInt(1, postId);
            checkStmt.setString(2, username);
            
            java.sql.ResultSet rs = checkStmt.executeQuery();
            rs.next();
            if (rs.getInt(1) > 0) {
                response.sendRedirect("community.jsp");
                return; // User already liked this post, do nothing
            }

            // Insert the like into the database
            String insertQuery = "INSERT INTO community_likes (post_id, username) VALUES (?, ?)";
            PreparedStatement ps = con.prepareStatement(insertQuery);
            ps.setInt(1, postId);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("community.jsp"); // Reload the page after liking
    }
}
