//
//  SeeAllPresenter.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import Foundation

final class SeeAllPresenter: SeeAllPresenterProtocol {
    func cellTapped() {
        //
    }
    
    func saveButtonTapped() {
        //
    }
    
    
    //MARK: - Properties
    
    var trendingNowRecipes: [RecipeInfo] = []
    
    weak var view: SeeAllViewProtocol?
    var router: SeeAllRouterProtocol

    init(router: SeeAllRouterProtocol, recipes: [RecipeInfo]) {
        
        self.router = router
        self.trendingNowRecipes = recipes
    }
}

//extension SeeAllPresenter: SeeAllPresenterProtocol {
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
