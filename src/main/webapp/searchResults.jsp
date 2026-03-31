<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.web.Recipe" %>
<!DOCTYPE html>
<html>
<head>
    <title>MealMate - Search Results</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
/* General Styles */
body {
    font-family: 'Arial', sans-serif;
    background: url('bg22.jpg') no-repeat center center fixed;
    background-size: cover;
    color: #343a40;
}

.container {
    background: rgba(255, 255, 255, 0.85);
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    max-width: 1100px;
    margin: 50px auto;
}

/* Navbar */
.navbar {
    background-color: #3E2723 !important; /* Dark brown for a rustic look */
}
.navbar-brand, .nav-link {
    color: #ffcc80 !important; /* Light orange for contrast */
}
.navbar-brand:hover, .nav-link:hover {
    color: #ffe0b2 !important;
}

/* Results Section */
.results-section {
    padding: 50px 20px;
    background: rgba(255, 245, 230, 0.95); /* Soft beige */
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    margin: 50px auto;
    max-width: 900px;
    text-align: center;
}
.results-section h2 {
    text-align: center;
    font-weight: bold;
    margin-bottom: 30px;
    color: #7C2E1C; /* Warm reddish-brown */
}

/* Recipe Card */
.recipe-card {
    margin-bottom: 20px;
    border: 1px solid #D7A86E; /* Warm golden border */
    border-radius: 10px;
    padding: 20px;
    background-color: white;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: left;
    transition: all 0.3s ease-in-out;
}
.recipe-card h3 {
    color: #BF8256; /* Soft caramel */
}
.recipe-card:hover {
    background-color: #F5E1C0; /* Light beige */
    transform: scale(1.03);
}

/* No Results */
.no-results {
    font-size: 18px;
    color: #B23A2F; /* Softer red */
    font-weight: bold;
    margin-top: 20px;
}

/* Back Button */
.back-button {
    margin-top: 20px;
    text-align: center;
}
.back-button a {
    text-decoration: none;
    color: white;
    background: #D7A86E; /* Warm golden brown */
    padding: 10px 20px;
    border-radius: 5px;
    transition: background 0.3s;
}
.back-button a:hover {
    background: #BF8256; /* Slightly darker caramel */
}

/* Icons */
.icon {
    color: #D7A86E; /* Matches the buttons */
    margin-right: 5px;
}

/* Footer */
footer {
    background-color: #4E342E; /* Deep mocha brown */
    color: white;
    text-align: center;
    padding: 10px 0;
    margin-top: 50px;
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

    <!-- Results Section -->
    <div class="results-section">
        <h2>Recipe Search Results</h2>
        <% 
            List<Recipe> recipes = (List<Recipe>) request.getAttribute("recipes");

            if (recipes == null || recipes.isEmpty()) { 
        %>
            <p class="no-results"><i class="fas fa-exclamation-circle"></i> No recipes found for the given search criteria.</p>
        <% 
            } else { 
                for (Recipe recipe : recipes) { 
                    if (recipe != null) { 
        %>
            <div class="recipe-card">
                <h3><i class="fas fa-utensils icon"></i> <%= (recipe.getName() != null) ? recipe.getName() : "No Name Available" %></h3>
                <p><i class="fas fa-tags icon"></i> <strong>Category:</strong> <%= (recipe.getCategory() != null) ? recipe.getCategory() : "Unknown" %></p>
                <p><i class="fas fa-seedling icon"></i> <strong>Ingredients:</strong> <%= (recipe.getIngredients() != null) ? recipe.getIngredients() : "Not Available" %></p>
                <p><i class="fas fa-clock icon"></i> <strong>Preparation Time:</strong> <%= recipe.getTime() %> minutes</p>
                <p><i class="fas fa-thermometer-half icon"></i> <strong>Difficulty:</strong> <%= recipe.getDifficulty() %></p>
                <p><i class="fas fa-book-open icon"></i> <strong>Instructions:</strong></p>
                <p><%= (recipe.getInstructions() != null) ? recipe.getInstructions() : "No instructions available." %></p>

                <!-- Embed YouTube Video -->
                <% 
                String youtubeLink = recipe.getYoutubeLink();
                if (youtubeLink != null && !youtubeLink.isEmpty()) { 
                    // Extract the video ID from the URL
                    String videoId = "";
                    if (youtubeLink.contains("watch?v=")) {
                        videoId = youtubeLink.split("watch\\?v=")[1].split("&")[0]; // Extracts VIDEO_ID
                    } else if (youtubeLink.contains("youtu.be/")) {
                        videoId = youtubeLink.split("youtu.be/")[1].split("\\?")[0]; // Extracts VIDEO_ID from shortened URL
                    }
            %>
                    <p><i class="fab fa-youtube icon"></i> <strong>Video Tutorial:</strong></p>
                    <iframe width="100%" height="315" 
                            src="https://www.youtube.com/embed/<%= videoId %>" 
                            style="border: none;" 
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                            allowfullscreen>
                    </iframe>
                <% 
                    } else { 
                %>
                    <p><i class="fas fa-video-slash icon"></i> No video tutorial available for this recipe.</p>
                <% } %>
            </div>
        <% 
                    } // End recipe null check
                } // End for loop
            } // End if-else block
        %>

        <!-- Back to Search Button -->
        <div class="back-button">
            <a href="recipeSearch.jsp"><i class="fas fa-arrow-left"></i> Back to Search</a>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2025S MealMate | Explore Delicious Recipes
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
