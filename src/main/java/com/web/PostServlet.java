package com.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;

@WebServlet("/PostServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // Limit file size to 10MB
public class PostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mealmatedb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String postContent = request.getParameter("post_content");
        Part filePart = request.getPart("post_image");

        byte[] imageBytes = null;
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream inputStream = filePart.getInputStream();
                 ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                imageBytes = outputStream.toByteArray();
            }
        }

        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Retrieve user_id based on username
            String userQuery = "SELECT id FROM users WHERE username = ?";
            try (PreparedStatement userPs = con.prepareStatement(userQuery)) {
                userPs.setString(1, username);
                try (ResultSet rs = userPs.executeQuery()) {
                    if (rs.next()) {
                        int userId = rs.getInt("id");

                        // Insert post with user_id
                        String query = "INSERT INTO community_posts (user_id, username, post_content, image_data) VALUES (?, ?, ?, ?)";
                        try (PreparedStatement ps = con.prepareStatement(query)) {
                            ps.setInt(1, userId);
                            ps.setString(2, username);
                            ps.setString(3, postContent);
                            if (imageBytes != null) {
                                ps.setBytes(4, imageBytes);
                            } else {
                                ps.setNull(4, java.sql.Types.BLOB);
                            }
                            ps.executeUpdate();
                        }
                    } else {
                        response.sendRedirect("community.jsp?error=UserNotFound");
                        return;
                    }
                }
            }
            response.sendRedirect("community.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("community.jsp?error=DatabaseError");
        }
    }
}
