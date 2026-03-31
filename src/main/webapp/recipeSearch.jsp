<%@ page import="java.util.List, com.web.Recipe" %>
<%
String username = (String) session.getAttribute("username");

if (username == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<%
    String keyword = request.getParameter("keyword");
    List<Recipe> recipes = (List<Recipe>) request.getAttribute("recipes");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>


<!DOCTYPE html>
<html>
<head>
    <title>MealMate - Recipe Search</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
/* General Styles */
body {
    font-family: 'Arial', sans-serif;
    background: url('bg22.jpg') no-repeat center center fixed; /* Set background */
    background-size: cover;
    color: #343a40;
}

.container {
    background: rgba(255, 255, 255, 0.85); /* Semi-transparent white background */
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

/* Search Section */
.search-section {
    padding: 50px 20px;
    background: rgba(255, 245, 230, 0.95); /* Light beige */
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    margin: 50px auto;
    max-width: 700px;
    text-align: center;
}
.search-section h2 {
    font-weight: bold;
    margin-bottom: 30px;
    color: #7C2E1C; /* Warm reddish-brown */
    text-shadow: 2px 2px 4px rgba(255, 255, 255, 0.7);
}
.btn-search {
    background-color: #D7A86E; /* Golden brown */
    color: white;
    font-size: 18px;
    border-radius: 8px;
}
.btn-search:hover {
    background-color: #BF8256; /* Warm caramel */
}

/* Random Recipes */
.random-recipes {
    margin-top: 50px;
    padding: 20px;
    background: rgba(255, 250, 245, 0.95); /* Light creamy tone */
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    max-width: 900px;
    margin: auto;
    text-align: center;
}
.random-recipes h3 {
    font-weight: bold;
    color: #5D4037; /* Soft brown */
}

/* Recipe Card */
.recipe-card {
    margin-bottom: 20px;
    padding: 20px;
    border-radius: 10px;
    background: white;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    text-align: center;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
}
.recipe-card:hover {
    background-color: #F5E1C0; /* Soft beige */
    transform: scale(1.05);
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

    <!-- Search Section -->
    <div class="search-section">
        <h2><i class="fas fa-search"></i> Find Your Favorite Recipes</h2>
        <form id="searchForm" action="SearchRecipeServlet" method="post">
            <input type="text" class="form-control" name="keyword" id="keywordInput" placeholder="Enter recipe name..." required>
            <br>
            <button type="submit" class="btn btn-search btn-block"><i class="fas fa-utensils"></i> Search Recipes</button>
        </form>
    </div>

    <!-- Random Recipes -->
    <div class="random-recipes">
        <h3>Try These Random Recipes</h3>
        <div class="row">
            <% 
                String[] randomRecipes = {"Pancakes", "Garlic Butter Shrimp", "Egg Fried Rice", "Chicken Biryani", "Chocolate Mousse", "Gulab Jamun"};
                for (String recipe : randomRecipes) { 
            %>
                <div class="col-md-4">
                    <div class="recipe-card" onclick="searchRecipe('<%= recipe %>')">
                        <h5><%= recipe %></h5>
                    </div>
                </div>
            <% } %>
            
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center mt-5 p-3 bg-dark text-white">
        &copy; 2025 MealMate | Explore Delicious Recipes
    </footer>

    <script>
        function searchRecipe(recipeName) {
            document.getElementById("keywordInput").value = recipeName;
            document.getElementById("searchForm").submit();
        }
    </script>
</body>
</html>
