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
    var trendingNowRecipes: [SearchRecipe] { get set }
    var popularCategoryRecipes: [SearchRecipe] { get set }
    var recentRecipe: [RecipeInfo] { get set }
    var networkManager: NetworkManager { get set }
    
    func getNewRecipes()
    func getRecipesByCategory()
}

final class MainPresenter: MainPresenterProtocol {

    weak var view: MainScreenViewControllerProtocol?
    var dataService: DataServiceProtocol
    var trendingNowRecipes: [SearchRecipe] = []
    var popularCategoryRecipes: [SearchRecipe] = []
    var recentRecipe: [RecipeInfo] = []
    var networkManager = NetworkManager.shared
    
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

extension MainPresenter: PopularCategoryHeaderCellDelegate {
    func getRecipesWithMealType(mealType: String) {
        networkManager.getRecipesWithMealType(for: mealType) { result in
            switch result {
            case .success(let recipes):
                self.popularCategoryRecipes =  recipes.results ?? []
                guard let view = self.view else { return }
                print("Популярная категория: \(self.popularCategoryRecipes)")
                view.getPopularRecipes()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
