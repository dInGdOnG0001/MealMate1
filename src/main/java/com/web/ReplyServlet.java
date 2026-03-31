package com.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ReplyServlet")
public class ReplyServlet extends HttpServlet {
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

        int postId = Integer.parseInt(request.getParameter("post_id"));
        String replyContent = request.getParameter("reply_content");

        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "INSERT INTO community_replies (post_id, username, reply_content) VALUES (?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setInt(1, postId);
                ps.setString(2, username);
                ps.setString(3, replyContent);
                ps.executeUpdate();
            }
            response.sendRedirect("community.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("community.jsp?error=DatabaseError");
        }
    }
}
