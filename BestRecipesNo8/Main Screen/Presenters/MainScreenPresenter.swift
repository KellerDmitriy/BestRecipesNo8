//
//  MainScreenPresenter.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 31.08.2023.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    var view : MainScreenViewControllerProtocol? { get set }
    var dataService: DataServiceProtocol { get set }
    var trendingNowRecipes: [RecipeInfo] { get set }
    var popularCategoryRecipes: [RecipeInfo] { get set }
    var recentRecipe: [RecipeInfo] { get set }
    
    func getNewRecipes()
    func getRecipesByCategory()
}

final class MainPresenter: MainPresenterProtocol {

    weak var view: MainScreenViewControllerProtocol?
    var dataService: DataServiceProtocol
    var trendingNowRecipes: [RecipeInfo] = []
    var popularCategoryRecipes: [RecipeInfo] = []
    var recentRecipe: [RecipeInfo] = []
    
    //MARK: LifeCycle
    
    required init(view: MainScreenViewControllerProtocol, dataService: DataServiceProtocol) {
        self.dataService = dataService
        self.view = view
    }
    
    func getNewRecipes() {
        
    }
    
    func getRecipesByCategory() {
        
    }
}
