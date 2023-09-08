//
//  PopularCategoryPreview.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 8.09.23.
//

import UIKit

enum PopularCategoryPreview {
    case salad([ListItem])
    case breakfast([ListItem])
    case appetizer([ListItem])
    case noodle([ListItem])
    case lunch([ListItem])
    
    var popularRecipes: [ListItem] {
        switch self {
        case .salad(let items),
             .breakfast(let items),
             .appetizer(let items),
             .noodle(let items),
             .lunch(let items):
            return items
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
}
