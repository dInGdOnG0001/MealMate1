<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>About Us - MealMate</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
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

.navbar {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
      h2 h3 {
    font-weight: bold;
    color: #5D4037;
}
        p {
            font-size: 16px;
            line-height: 1.6;
        }
        .chat-section {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 50px auto;
            max-width: 600px;
            text-align: center;
        }
        .chat-box {
            width: 100%;
            height: 250px;
            overflow-y: auto;
            border: 1px solid #ddd;
            padding: 10px;
            background: white;
            border-radius: 5px;
            text-align: left;
        }
        .chat-input {
            width: 80%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-right: 5px;
        }
        .send-btn {
            background: #ff7043;
            border: none;
            padding: 10px 15px;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        .send-btn:hover {
            background: #e64a19;
        }
        .footer {
            background-color: #343a40;
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

    <div class="container">
        <h2>About MealMate</h2>
        <p>
            MealMate was created to make cooking easier and more fun! Whether you're looking for recipe ideas, meal recommendations, or a place to share your cooking experiences, we've got you covered.
        </p>
        <h3>📅 When Was MealMate Created?</h3>
        <p>
            MealMate was launched in <b>2024</b> as a student project. Our goal is to bring food lovers together and simplify meal planning.
        </p>
        <h3>🔍 How Does MealMate Work?</h3>
        <p>
            -<b>Recipe Search</b>: Find recipes that you want make.<br>  
            - <b>Meal Recommendations</b>: Our system provides personalized meal recommendations for you.<br> 
            - <b>Community</b>: Share recipes, ask for cooking tips, and interact with other users.<br>
            -<b> Shopping List Generator</b>: Users can generate a shopping list based on selected recipes for easy grocery shopping.
        </p>
        <h3>🚀 Future Plans</h3>
        <p>
            I plan to add <b>more AI-powered recommendations, personalized meal plans, and a mobile app version</b> in the future. Stay tuned!
        </p>
    </div>

    <!-- Chat Section -->
    <div class="chat-section">
        <h3>Know More About Us</h3>
        <p>Ask something about MealMate, and we'll respond!</p>
        <div class="chat-box" id="chat-box">
            <p><strong>Bot:</strong> Hi! Ask me about MealMate. 😊</p>
        </div>
        <br>
        <input type="text" class="chat-input" id="chat-input" placeholder="Type your question..." onkeypress="handleKeyPress(event)">
        <button class="send-btn" onclick="sendMessage()">Send</button>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2025 MealMate | Designed for Food Lovers
    </footer>

    <script>
        function handleKeyPress(event) {
            if (event.key === "Enter") {
                sendMessage();
            }
        }

        function sendMessage() {
            var input = document.getElementById("chat-input").value.trim();
            if (input === "") return;

            var chatBox = document.getElementById("chat-box");
            chatBox.innerHTML += "<p><strong>You:</strong> " + input + "</p>";

            var response = getBotResponse(input.toLowerCase());
            setTimeout(() => {
                chatBox.innerHTML += "<p><strong>Bot:</strong> " + response + "</p>";
                chatBox.scrollTop = chatBox.scrollHeight;
            }, 500);

            document.getElementById("chat-input").value = "";
        }

        function getBotResponse(message) {
            message = message.toLowerCase();

            // Greetings
            if (message.includes("hi") || message.includes("hello")) {
                return "Hello! 😊 How can I help you today?";
            } else if (message.includes("how are you")) {
                return "I'm just a bot, but I'm feeling great! Thanks for asking. How can I assist you?";
            } 
            
            // MealMate Information
            else if (message.includes("who created") || message.includes("who made")) {
                return "MealMate was developed by Ashish in 2024 as a student project to help people find and share recipes!";
            } else if (message.includes("when") && message.includes("created")) {
                return "MealMate was launched in 2024! 🚀";
            } else if (message.includes("how") && message.includes("work")) {
                return "MealMate works by providing recipe search, meal recommendations, and a community for food lovers!";
            } 
            
            // Features & Functionality
            else if (message.includes("recommendation")) {
                return "Our system provides personalized meal recommendations based on your preferences! Try it out!";
            } else if (message.includes("community")) {
                return "Join our community to share recipes, get cooking tips, and interact with food lovers! 🍽️";
            } else if (message.includes("upload") || message.includes("add my own recipe")) {
                return "Yes! You can upload your own recipes in the community section. Just go to 'Community' and share your favorite dishes!";
            } else if (message.includes("difference") || message.includes("special about mealmate")) {
                return "MealMate provides user-based meal recommendations, a shopping list generator, and a community for food lovers! 🥗🍕";
            } else if (message.includes("future") || message.includes("plan")) {
                return "We're working on adding AI-powered meal plans, a mobile app version, and even voice-assisted cooking guides!";
            } 
            
            // Account & Login
            else if (message.includes("login") || message.includes("register")) {
                return "You can sign up or log in to save your favorite recipes and post in the community!";
            } else if (message.includes("forgot password")) {
                return "Try resetting your password on the login page. If you need further help, contact support.";
            } 

            // Fun & Casual
            else if (message.includes("tell me a joke")|| message.includes("joke")) {
                return "Why did the tomato turn red? 🍅 Because it saw the salad dressing! 😂";
            } else if (message.includes("favorite recipe") || message.includes("what do you like to eat")) {
                return "I don't eat, but if I could, I'd love to try a nice homemade pizza! 🍕";
            } else if (message.includes("do you cook")) {
                return "I wish I could! But I can definitely help you find the best recipes! 👨‍🍳";
            } else if (message.includes("thank you") || message.includes("thanks")) {
                return "You're welcome! 😊 Enjoy your cooking!";
            } else if (message.includes("you are smart") || message.includes("good bot")) {
                return "Aww, thank you! I try my best. 😊";
            }

            // Default Response
            else {
                return "I'm not sure about that. Try asking about MealMate, recipes, recommendations, or our community!";
            }
        }

    </script>

</body>
</html>
