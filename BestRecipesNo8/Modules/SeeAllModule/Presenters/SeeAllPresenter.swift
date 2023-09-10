//
//  SeeAllPresenter.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import Foundation

protocol SeeAllPresenterProtocol: AnyObject {
    var trendingNowRecipes: [RecipeInfo] { get }
    var router: SeeAllRouterInput { get }
}

final class SeeAllPresenter: SeeAllPresenterProtocol {
    
    //MARK: - Properties
    
    var trendingNowRecipes: [RecipeInfo] = []
    
    weak var view: SeeAllViewInput?
    var router: SeeAllRouterInput

    init(router: SeeAllRouterInput, recipes: [RecipeInfo]) {
        
        self.router = router
        self.trendingNowRecipes = recipes
    }
}

//extension SeeAllPresenter: SeeAllViewOutput {
//
//    func saveButtonTapped() {
//        //
//    }
//
//    func fetchData(for category: String) {
//        //
//    }
//
////    func cellTapped() {
////        self.router.routeToRecipeDetailScreen(recipe: <#T##RecipeInfo#>)
////    }
//
//
//}
