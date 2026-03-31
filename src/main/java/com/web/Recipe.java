package com.web;

public class Recipe {
    private int id;
    private String name;
    private String ingredients;
    private String category;
    private String time;
    private String instructions;
    private String difficulty;
    private String ytLink;

    // Getters and setters for all fields
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIngredients() {
        return ingredients;
    }

    public void setIngredients(String ingredients) {
        this.ingredients = ingredients;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getInstructions() {
        return instructions;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }

    public String getYoutubeLink() {  // 🔥 Rename this method instead of using getYtLink()
        return ytLink;
    }

    // Setter if needed
    public void setYoutubeLink(String ytLink) {
        this.ytLink = ytLink;
    }
    
    public String getDifficulty() {
    	return difficulty;
    }
    
    public void setDifficulty( String difficulty) {
    	this.difficulty = difficulty;
    }

	
}

