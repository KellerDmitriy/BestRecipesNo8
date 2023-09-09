//
//  ListSection.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import Foundation

enum ListSection {
    case trendingNow([RecipeItem])
    case popularCategories([RecipeItem])
    case popularRecipe(PopularCategoryPreview)
    case recentRecipe([RecipeItem])
    case teamMembers([RecipeItem])
    
    var items: [RecipeItem] {
        switch self {
        case .trendingNow(let items),
                .popularCategories(let items),
                .recentRecipe(let items),
                .teamMembers(let items):
            return items
        case .popularRecipe(let category):
            return category.popularRecipes
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
        case .trendingNow:
            return "Trending now \u{1F525}"
        case .popularCategories:
            return "Popular category"
        case .popularRecipe:
            return ""
        case .recentRecipe:
            return "Recent recipe"
        case .teamMembers:
            return "Team members"
        }
    }
}
