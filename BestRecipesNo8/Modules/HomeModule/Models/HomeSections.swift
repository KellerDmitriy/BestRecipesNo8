//
//  ListSection.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import Foundation

enum HomeSections {
    case trendingNow
    case popularCategories
    case popularRecipe
    case recentRecipe
    case teamMembers
    
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

struct SectionsData {
    static let shared = SectionsData()
    private let trendingNow = HomeSections.trendingNow
    private let popularCategories = HomeSections.popularCategories
    private let popularRecipe = HomeSections.popularRecipe
    private let recentRecipe = HomeSections.recentRecipe
    private let teamMembers = HomeSections.teamMembers
    var sectionsArray: [HomeSections] {
        [trendingNow, popularCategories, popularRecipe, recentRecipe, teamMembers]
    }
}
