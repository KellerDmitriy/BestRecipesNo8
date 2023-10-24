//
//  ManagerSections.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 24.10.2023.
//

import Foundation

protocol ManagerSectionsProtocol {
    func getDimensions(section: HomeSections) -> (itemWidth: CGFloat, itemHeight: CGFloat, groupWidth: CGFloat, groupHeight: CGFloat)
}

class ManagerSections: ManagerSectionsProtocol {
    
    func getDimensions(section: HomeSections) -> (itemWidth: CGFloat, itemHeight: CGFloat, groupWidth: CGFloat, groupHeight: CGFloat) {
        
        switch section {
        case .trendingNow: return (1, 0.9, 0.8, 0.6)
        case .popularCategories: return (1, 0.35, 0.21, 0.2)
        case .popularRecipe: return (1, 0.9, 0.4, 0.4)
        case .randomRecipe: return (1, 0.9, 0.33, 0.45)
        case .teamMembers: return (1, 1, 0.4, 0.45)
        }
    }
}
