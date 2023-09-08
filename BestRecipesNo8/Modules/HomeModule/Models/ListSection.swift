//
//  ListSection.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import Foundation

enum ListSection {
    case trendingNow([ListItem])
    case popularCategories([ListItem])
    case popularRecipe([ListItem])
    case recentRecipe([ListItem])
    case teamMembers([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .trendingNow(let items),
                .popularCategories(let items),
                .popularRecipe(let items),
                .recentRecipe(let items),
                .teamMembers(let items):
            return items
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
