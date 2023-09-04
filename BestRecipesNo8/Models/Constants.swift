//
//  Constants.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 28.08.2023.
//

import Foundation

struct Constants {
    
    // https://spoonacular.com/food-api/docs#Meal-Types
    // параметр для запроса = type
    static let mealTypes = ["main course",
                            "dessert",
                            "appetizer",
                            "salad",
                            "bread",
                            "breakfast",
                            "soup",
                            "beverage",
                            "sauce",
                            "marinade",
                            "fingerfood",
                            "snack",
                            "drink"]
    
    // https://spoonacular.com/food-api/docs#Cuisines
    // параметр для запроса = cuisine
    static let cuisines = ["African",
                           "Asian",
                           "American",
                           "British",
                           "Cajun",
                           "Caribbean",
                           "Chinese",
                           "Eastern European",
                           "European",
                           "French",
                           "German",
                           "Greek",
                           "Indian",
                           "Irish",
                           "Italian",
                           "Japanese",
                           "Jewish",
                           "Korean",
                           "Latin American",
                           "Mediterranean",
                           "Mexican",
                           "Middle Eastern",
                           "Nordic",
                           "Southern",
                           "Spanish",
                           "Thai",
                           "Vietnamese"]
    
    // https://spoonacular.com/food-api/docs#Diets
    // параметр для запроса = diet
    static let diet = ["Gluten Free",
                       "Ketogenic",
                       "Vegetarian",
                       "Lacto-Vegetarian",
                       "Ovo-Vegetarian",
                       "Vegan",
                       "Pescetarian",
                       "Paleo",
                       "Primal",
                       "Low FODMAP",
                       "Whole30"]
}
