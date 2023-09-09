//
//  PopularCategoryPreview.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 8.09.23.
//

import UIKit

enum PopularCategoryPreview {
    case salad
    case breakfast
    case appetizer
    case noodle
    case lunch
    
    var popularRecipes: [RecipeItem] {
        switch self {
        case .salad:
            return saladRecipes
        case .breakfast:
            return breakfastRecipes
        case .appetizer:
            return appetizerRecipes
        case .noodle:
            return saladRecipes
        case .lunch:
            return saladRecipes
        }
    }
    
    var count: Int {
        popularRecipes.count
    }
    
    var title: String {
        switch self {
        case .salad:
            return "Salad"
        case .breakfast:
            return "Breakfast"
        case .appetizer:
            return "Appetizer"
        case .noodle:
            return "Noodle"
        case .lunch:
            return "Lunch"
        }
    }
    
    var saladRecipes: [RecipeItem] {[
        .init(title: "Chicken and Vegetable wrap", image: UIImage(named: "popularImage1"), time: 1),
        .init(title: "Chicken and Vegetable wrap", image: UIImage(named: "popularImage2"), time: 2),
        .init(title: "Chicken and Vegetable wrap", image: UIImage(named: "popularImage1"), time: 3)
    ]}

    var breakfastRecipes: [RecipeItem] {[
        .init(title: "Chicken and Vegetable wrap", image: UIImage(named: "popularImage2"), time: 4),
        .init(title: "Chicken and Vegetable wrap", image: UIImage(named: "popularImage1"), time: 5),
        .init(title: "Chicken and Vegetable wrap", image: UIImage(named: "popularImage2"), time: 6)
    ]}
    
    var appetizerRecipes: [RecipeItem] {[
        .init(title: "Chicken and Vegetable wrap", image: UIImage(named: "popularImage1"), time: 7),
        .init(title: "Chicken and Vegetable wrap", image: UIImage(named: "popularImage2"), time: 8),
        .init(title: "Chicken and Vegetable wrap", image: UIImage(named: "popularImage1"), time: 9)
    ]}
}
