//
//  SeeAllPresenter.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import Foundation

protocol SeeAllPresenterProtocol: AnyObject {
    var trendingNowRecipes: [RecipeInfo] { get }
}

final class SeeAllPresenter: SeeAllPresenterProtocol {
    
    //MARK: - Properties
    
    var trendingNowRecipes: [RecipeInfo] = []
    
    weak var view: SeeAllViewInput?
    private let router: SeeAllRouterInput
   // private let settingsManager: SettingsManagerProtocol

    init(router: SeeAllRouterInput, recipes: [RecipeInfo]) {
        
        self.router = router
        self.trendingNowRecipes = recipes
        //self.settingsManager = settingsManager
    }
}

extension SeeAllPresenter: SeeAllViewOutput {
    
    func saveButtonTapped() {
        //
    }
    
    func fetchData(for category: String) {
        //
    }
    
    func cellTapped() {
        self.router.routeToRecipeDetailScreen()
    }
    

}
