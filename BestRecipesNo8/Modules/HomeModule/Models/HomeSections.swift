//
//  ListSection.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import UIKit

enum HomeSections {
    case trendingNow
    case popularCategories
    case popularRecipe
    case randomRecipe
    case teamMembers([Team])
    
    var title: String {
        switch self {
        case .trendingNow:
            return "Trending now \u{1F525}"
        case .popularCategories:
            return "Popular category"
        case .popularRecipe:
            return ""
        case .randomRecipe:
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
    private let recentRecipe = HomeSections.randomRecipe
    private let teamMembers: HomeSections = .teamMembers(Team.teamMembersData)
    private init(){}

    var sectionsArray: [HomeSections] {
        [trendingNow, popularCategories, popularRecipe, recentRecipe, teamMembers]
    }
}

