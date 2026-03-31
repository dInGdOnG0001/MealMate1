<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.web.Recipe" %>
<%
String username = (String) session.getAttribute("username");

if (username == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>MealMate - Recipe Recommendations</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
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
    max-width: 1100px;
    margin: 50px auto;
}

/* Navbar */
.navbar {
    background-color: #3E2723 !important; /* Dark brown */
}
.navbar-brand, .nav-link {
    color: #ffcc80 !important;
}
.navbar-brand:hover, .nav-link:hover {
    color: #ffe0b2 !important;
}

/* Darker Headings */
h3 {
    text-align: center;
    font-weight: bold;
    color: #5C2E0F; /* Rich Dark Brown */
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    padding: 12px;
}

/* Recipe Cards */
.recipe-card {
    background: rgba(255, 255, 255, 0.95);
    border: 1px solid #d1a065; /* Warm golden border */
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    margin-bottom: 20px;
    transition: transform 0.3s ease-in-out;
}

.recipe-card:hover {
    transform: scale(1.05);
    background: #ffe0b2;
}

.recipe-card h3 {
    font-size: 22px;
    font-weight: bold;
    color: #4E342E; /* Dark Mocha */
}

.recipe-card p {
    font-size: 16px;
    color: #3E2723; /* Deep Brown */
}

.recipe-card i {
    color: #ff7043;
}

/* Buttons */
.btn-block {
    background-color: #D7A86E;
    color: white;
    border: none;
    font-size: 18px;
    font-weight: bold;
    padding: 12px;
    border-radius: 8px;
    transition: background 0.3s, transform 0.2s;
}

.btn-block:hover {
    background-color: #D7A86E;
    transform: scale(1.05);
}

.btn-block .icon {
    margin-right: 8px;
}

/* Footer */
footer {
    background-color: #3E2723;
    color: white;
    text-align: center;
    padding: 10px 0;
    position: fixed;
    width: 100%;
    bottom: 0;
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

    <!-- **Recommendation Form** -->
    <div class="container mt-5">
        <div class="recommend-form">
            <h3 class="text-center">Get Recipe Recommendations</h3>
            <form action="RecommendationServlet" method="GET">
                <div class="form-group">
                    <label for="ingredient">Main Ingredient:</label>
                    <input type="text" id="ingredient" name="ingredient" class="form-control" placeholder="Enter an ingredient (e.g., Chicken)">
                </div>

                <div class="form-group">
                    <label for="category">Category:</label>
                    <select id="category" name="category" class="form-control">
                        <option value="">Any</option>
                        <option value="Breakfast">Breakfast</option>
                        <option value="Thai">Thai</option>
                        <option value="Indian">Indian</option>
                        <option value="Dessert">Dessert</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="time">Max Cooking Time (minutes):</label>
                    <input type="number" id="time" name="time" class="form-control" min="1" max="120">
                </div>

                <div class="form-group">
                    <label for="difficulty">Difficulty:</label>
                    <select id="difficulty" name="difficulty" class="form-control">
                        <option value="">Any</option>
                        <option value="Easy">Easy</option>
                        <option value="Medium">Medium</option>
                        <option value="Hard">Hard</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-block fa-solid  fa-utensils icon">Get Recommendations</button>
            </form>
        </div>
    </div>

<!-- **Recommended Recipes Section** -->
    <div class="container">
        <h3 class="mt-4">Recommended Recipes</h3>
        <div class="row">
            <% 
                List<Recipe> recommendedRecipes = (List<Recipe>) request.getAttribute("recommendedRecipes");
                if (recommendedRecipes != null && !recommendedRecipes.isEmpty()) {
                    for (Recipe recipe : recommendedRecipes) { 
            %>
                <div class="col-md-4">
                    <div class="recipe-card">
                        <h3><i class="fa-solid  fa-utensils icon"></i> <%= (recipe.getName() != null) ? recipe.getName() : "No Name Available" %></h3>
                        <p><i class="fa-solid  fa-tags icon"></i> <strong>Category:</strong> <%= (recipe.getCategory() != null) ? recipe.getCategory() : "Unknown" %></p>
                        <p><i class="fa-solid  fa-seedling icon"></i> <strong>Ingredients:</strong> <%= (recipe.getIngredients() != null) ? recipe.getIngredients() : "Not Available" %></p>
                        <%
                        int prepTime = 0;
                        try {
                            prepTime = Integer.parseInt(recipe.getTime()); // Convert String to int
                        } catch (NumberFormatException e) {
                            prepTime = 0; // Default to 0 if conversion fails
                        }
                    %>
                    <p><i class="fa-solid  fa-clock icon"></i> <strong>Preparation Time:</strong> 
                        <%= (prepTime > 0) ? prepTime + " minutes" : "N/A" %>
                    </p>
                        <p><i class="fa-solid  fa-thermometer-half icon"></i> <strong>Difficulty:</strong> <%= (recipe.getDifficulty() != null) ? recipe.getDifficulty() : "Unknown" %></p>
                        <p><i class="fa-solid  fa-book-open icon"></i> <strong>Instructions:</strong></p>
                        <p><%= (recipe.getInstructions() != null) ? recipe.getInstructions() : "No instructions available." %></p>
                        <% if (recipe.getYoutubeLink() != null && !recipe.getYoutubeLink().isEmpty()) { %>
    <p>
        <i class="fa-brands fa-youtube icon" style="color: red;"></i> 
        <strong>Watch Tutorial:</strong> 
        <a href="<%= recipe.getYoutubeLink() %>" target="_blank" class="btn btn-sm btn-danger">Watch on YouTube</a>
    </p>
<% } %>
                    </div>
                </div>
            <% 
                    } 
                } else { 
            %>
                <p>No recommendations found.</p>
            <% } %>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
