package com.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;

@WebServlet("/DisplayImageServlet")
public class DisplayImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mealmatedb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int postId;
        try {
            postId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Post ID");
            return;
        }

        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT image_data FROM community_posts WHERE id = ?";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setInt(1, postId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        byte[] imageData = rs.getBytes("image_data");
                        if (imageData != null) {
                            response.setContentType("image/jpeg"); // Default to JPEG
                            response.setContentLength(imageData.length);
                            try (OutputStream os = response.getOutputStream()) {
                                os.write(imageData);
                            }
                        } else {
                            response.sendError(HttpServletResponse.SC_NOT_FOUND, "No image found");
                        }
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Post not found");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        }
    }
}
