<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Ensure user is logged in
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/mealmatedb";
    String dbUser = "root";
    String dbPass = "root";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Community - MealMate</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
/* General Styles */
body {
    font-family: 'Arial', sans-serif;
    background: url('bg22.jpg') no-repeat center center fixed;
    background-size: cover;
    color: #343a40;
}

.container {
    background: rgba(255, 255, 255, 0.9);
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    max-width: 900px;
    margin: 50px auto;
}

/* Post Styles */
.post-container {
    background: #fff;
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    border-left: 5px solid #D7A86E;
    transition: transform 0.2s ease-in-out, box-shadow 0.3s ease-in-out;
}
.post-container:hover {
    transform: scale(1.02);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
}
.post-user {
    font-weight: bold;
    color: #5C2E0F;
}
.post-content {
    font-size: 16px;
    margin-bottom: 10px;
}

.delete-btn {
    background: none;
    border: none;
    color: red;
    cursor: pointer;
    font-size: 14px;
}

/* Reply Section */
.reply-container {
    background: #f9f9f9;
    padding: 15px;
    margin-top: 10px;
    border-left: 3px solid #D7A86E;
    border-radius: 10px;
}
.reply-user {
    font-weight: bold;
    color: #3E2723;
}

/* Footer */
footer {
    background-color: #4E342E;
    color: white;
    text-align: center;
    padding: 12px 0;
    margin-top: 40px;
    font-size: 14px;
    border-top: 3px solid #D7A86E;
}
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="index.html">MealMate</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="index.html">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="recipeSearch.jsp">Recipe Search</a></li>
                <li class="nav-item"><a class="nav-link" href="recommendation.jsp">Recommendations</a></li>
                <li class="nav-item"><a class="nav-link" href="shoppingList.jsp">Shopping List</a></li>
                <li class="nav-item"><a class="nav-link" href="community.jsp">Community</a></li>
                <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <h2>Welcome, <%= username %>!</h2>
        <a href="logout.jsp" class="btn btn-danger">Logout</a>
        <h3>Post Something</h3>
        <form action="PostServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="username" value="<%= username %>">
            <div class="form-group">
                <textarea class="form-control" name="post_content" placeholder="Share your thoughts or recipes..." required></textarea>
            </div>
            <div class="form-group">
                <label>Upload Image (JPG/PNG only):</label>
                <input type="file" class="form-control" name="post_image" accept="image/png, image/jpeg">
            </div>
            <button type="submit" class="btn btn-primary" style="background-color: #D7A86E">Post</button>
        </form>

        <hr>
        <h3>Community Posts</h3>
        <div class="posts">
            <%
            try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
                String query = "SELECT id, username, post_content FROM community_posts ORDER BY created_at DESC";
                PreparedStatement ps = con.prepareStatement(query);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    int postId = rs.getInt("id");
                    String postUser = rs.getString("username");
                    String postContent = rs.getString("post_content");

                    out.println("<div class='post-container' id='post-" + postId + "'>");
                    out.println("<p class='post-user'>" + postUser + "</p>");
                    out.println("<p>" + postContent + "</p>");
                    out.println("<img src='DisplayImageServlet?id=" + postId + "' class='img-fluid' style='max-width: 200px;'>");

                    // Fetch like count for the post
                    PreparedStatement likePs = con.prepareStatement("SELECT COUNT(*) FROM community_likes WHERE post_id = ?");
                    likePs.setInt(1, postId);
                    ResultSet likeRs = likePs.executeQuery();
                    likeRs.next();
                    int likeCount = likeRs.getInt(1);

                    // Like Button & Count
                    out.println("<form action='LikePostServlet' method='post' style='display:inline;'>");
                    out.println("<input type='hidden' name='post_id' value='" + postId + "'>");
                    out.println("<button type='submit' class='btn btn-outline-primary btn-sm'>👍 Like (" + likeCount + ")</button>");
                    out.println("</form>");

                    // Delete button (Only if user is the author)
                    if (postUser.equals(username)) {
                        out.println("<form action='DeletePostServlet' method='post' style='display:inline;'>");
                        out.println("<input type='hidden' name='post_id' value='" + postId + "'>");
                        out.println("<button type='submit' class='delete-btn'>🗑️ Delete</button>");
                        out.println("</form>");
                    }

                    // Reply form
                    out.println("<form action='ReplyServlet' method='post'>");
                    out.println("<input type='hidden' name='post_id' value='" + postId + "'>");
                    out.println("<input type='hidden' name='username' value='" + username + "'>");
                    out.println("<textarea name='reply_content' class='form-control' placeholder='Write a reply...' required></textarea>");
                    out.println("<button type='submit' class='btn btn-secondary btn-sm mt-2'>Reply</button>");
                    out.println("</form>");

                    // Display Replies
                    out.println("<div class='reply-container'>");
                    PreparedStatement replyPs = con.prepareStatement("SELECT username, reply_content FROM community_replies WHERE post_id = ? ORDER BY created_at ASC");
                    replyPs.setInt(1, postId);
                    ResultSet replyRs = replyPs.executeQuery();

                    while (replyRs.next()) {
                        String replyUser = replyRs.getString("username");
                        String replyContent = replyRs.getString("reply_content");
                        out.println("<p><span class='reply-user'>" + replyUser + ":</span> " + replyContent + "</p>");
                    }
                    out.println("</div>"); // End reply-container

                    out.println("</div>"); // End post-container
                }
            } catch (Exception e) {
                out.println("<p>Error loading posts: " + e.getMessage() + "</p>");
            }
        %>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2025 MealMate | Designed for Food Lovers
    </footer>
</body>
</html>