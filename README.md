# MealMate

A Java web application built with JSP, Jakarta Servlets, and MySQL for recipe discovery, personalized meal recommendations, shopping list management, and community food discussions.

## Features
- **User & Admin Authentication:** Secure registration and login flows (`LoginServlet`, `RegisterServlet`, `AdminLoginServlet`).
- **Recipe Management & Search:** Browse, search, add, and update recipes with image rendering (`Recipe`, `SearchRecipeServlet`, `AdminRecipeServlet`, `UpdateRecipeServlet`, `DisplayImageServlet`).
- **Smart Recommendations & Shopping List:** Personalized meal suggestions and ingredient tracking (`RecommendationServlet`, `ShoppingListServlet`).
- **Community Forum:** Create posts, like recipes/discussions, and post threaded replies (`PostServlet`, `LikePostServlet`, `ReplyServlet`).

## Tech Stack
- **Backend:** Java, Jakarta Servlet API, JSP
- **Server:** Apache Tomcat 10.1
- **Database:** MySQL (`mealmatedb`) via JDBC

## Local Setup & Running the Project
1. **Clone the repository:**
   ```bash
   git clone [https://github.com/dInGdOnG0001/MealMate1.git](https://github.com/dInGdOnG0001/MealMate1.git)
