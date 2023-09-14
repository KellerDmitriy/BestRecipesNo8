//
//  HomePresenter.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 14.09.23.
//

import Foundation

final class HomePresenter {
    
    weak var view: HomeViewInput?
    private let router: HomeRouterInput
    private let settingsManager: SettingsManagerProtocol

    init(router: HomeRouterInput,settingsManager: SettingsManagerProtocol) {
        
        self.router = router
        self.settingsManager = settingsManager
    }
    
    func getDimensions(section: HomeSections) -> (itemWidth: CGFloat, itemHeight: CGFloat, groupWidth: CGFloat, groupHeight: CGFloat) {
        
        switch section {
        case .trendingNow: return (1, 0.9, 0.8, 0.6)
        case .popularCategories: return (1, 0.35, 0.21, 0.2)
        case .popularRecipe: return (1, 0.9, 0.4, 0.4)
        case .recentRecipe: return (1, 0.9, 0.33, 0.45)
        case .teamMembers: return (1, 1, 0.4, 0.45)
        }
    }
}
