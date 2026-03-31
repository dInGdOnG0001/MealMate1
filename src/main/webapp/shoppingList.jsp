<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
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
    <title>MealMate - Shopping List Generator</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        body {
    font-family: 'Arial', sans-serif;
    background: url('bg22.jpg') no-repeat center center fixed;
    background-size: cover;
    color: #343a40;
}

/* Container Background */
.container {
    background: rgba(255, 245, 235, 0.9); /* Light creamy beige */
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    max-width: 700px;
    margin: 50px auto;
}

/* Navbar */
.navbar {
    background-color: #3E2723 !important;
}
.navbar-brand, .nav-link {
    color: #ffcc80 !important;
}
.navbar-brand:hover, .nav-link:hover {
    color: #ffe0b2 !important;
}

/* Buttons */
.btn-search, .shopping-button a {
    background: #D7A86E; /* Warm golden beige */
    color: white;
    border: none;
    font-weight: bold;
}
.btn-search:hover, .shopping-button a:hover {
    background: #BF8256; /* Soft caramel */
}

/* Shopping List Buttons */
.shopping-button {
    text-align: center;
    margin-top: 20px;
}
.shopping-button a {
    text-decoration: none;
    color: white;
    padding: 10px 20px;
    border-radius: 5px;
}

/* Table */
table {
    width: 100%;
    margin-top: 20px;
}
th, td {
    padding: 10px;
    text-align: left;
}
th {
    background-color: #8D6E63; /* Soft cocoa brown */
    color: white;
}

/* No Results */
.no-results {
    font-size: 18px;
    color: #d9534f;
    font-weight: bold;
    margin-top: 20px;
    text-align: center;
}

/* Footer */
footer {
    background-color: #5D4037; /* Chocolate brown */
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


    <!-- Shopping List Generator -->
    <div class="container">
        <h2 class="text-center">Shopping List Generator</h2>
        <form action="ShoppingListServlet" method="post">
            <div class="form-group">
                <label for="recipeName">Enter Recipe Name:</label>
                <input type="text" class="form-control" id="recipeName" name="recipeName" required>
            </div>
            <button type="submit" class="btn btn-search btn-block">Generate Shopping List</button>
        </form>
        
        <% 
            String recipeName = request.getParameter("recipeName");
            List<String> ingredients = (List<String>) request.getAttribute("ingredients");
            Map<String, Integer> ingredientPrices = (Map<String, Integer>) request.getAttribute("ingredientPrices");

            if (ingredients != null && !ingredients.isEmpty()) { 
        %>
           <h3 class="mt-4 text-center">Shopping List for <span style="color:#e64a19;"><%= (recipeName != null && !recipeName.isEmpty()) ? recipeName : "Recipe" %></span></h3>

            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Ingredient</th>
                        <th>Estimated Price (₹)</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (String ingredient : ingredients) { %>
                        <tr>
                            <td><%= ingredient %></td>
                            <td>₹<%= ingredientPrices.get(ingredient) %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="shopping-button">
                <a href="https://www.amazon.in/s?k=grocery" target="_blank">Buy from Amazon India</a> |
                <a href="https://www.bigbasket.com/" target="_blank">Buy from BigBasket</a> |
                <a href="https://www.jiomart.com/c/groceries/1" target="_blank">Buy from JioMart</a>
            </div>
        <% } else if (request.getAttribute("error") != null) { %>
            <p class="no-results"><i class="fas fa-exclamation-circle"></i> No ingredients found for the entered recipe.</p>
        <% } %>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2025 MealMate | Explore Delicious Recipes
    </footer>
</body>
</html>
