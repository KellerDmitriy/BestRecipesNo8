//
//  ListSection.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import Foundation
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

struct Team {
    let title: String
    let image: UIImage?
    init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    static let teamMembersData: [Team] = [
        .init(title: "Kitty 1", image: UIImage(named: "member1")),
        .init(title: "Kitty 2", image: UIImage(named: "member2")),
        .init(title: "Kitty 3", image: UIImage(named: "member3")),
        .init(title: "Kitty 4", image: UIImage(named: "member4")),
        .init(title: "Kitty 5", image: UIImage(named: "member5"))
    ]
    
}

struct SectionsData {
    static let shared = SectionsData()

    private let trendingNow = HomeSections.trendingNow
    private let popularCategories = HomeSections.popularCategories
    private let popularRecipe = HomeSections.popularRecipe
    private let recentRecipe = HomeSections.randomRecipe
    

    
    private let teamMembers: HomeSections = .teamMembers(Team.teamMembersData)

    var sectionsArray: [HomeSections] {
        [trendingNow, popularCategories, popularRecipe, recentRecipe, teamMembers]
    }
}
