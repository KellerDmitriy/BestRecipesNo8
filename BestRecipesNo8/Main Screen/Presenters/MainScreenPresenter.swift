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
    var networkManager: NetworkManager { get set }
    
    func seeAllButtonTapped()
    func addButtonTapped()
    
    func getNewRecipes()
    func getRecipesByCategory()
}

final class MainPresenter: MainPresenterProtocol {
    
    
    
    weak var view: MainScreenViewControllerProtocol?
    var dataService: DataServiceProtocol
    var trendingNowRecipes: [RecipeInfo] = []
    var popularCategoryRecipes: [RecipeInfo] = []
    var recentRecipe: [RecipeInfo] = []
    var networkManager = NetworkManager.shared
    
    private let router: MainRouterInput
    
    //MARK: LifeCycle
    
    required init(view: MainScreenViewControllerProtocol, dataService: DataServiceProtocol, router: MainRouterInput) {
        self.dataService = dataService
        self.view = view
        self.router = router
    }
    
    func seeAllButtonTapped() {
        self.router.routeToSeeAllScreen(recipes: trendingNowRecipes)
    }
    
    func addButtonTapped() {
        // обновить массив savedRecipe UD!
        print("addButtonTapped")
    }
    
    func getNewRecipes() {
        
    }
    
    func getRecipesByCategory() {
        
    }
}

extension MainPresenter: PopularCategoryHeaderCellDelegate {
    //    func getRecipesWithMealType(mealType: String) {
    //        networkManager.getRecipesWithMealType(for: mealType) { result in
    //            switch result {
    //            case .success(let recipes):
    //                self.popularCategoryRecipes =  recipes.results ?? []
    //                guard let view = self.view else { return }
    //                print("Популярная категория: \(self.popularCategoryRecipes)")
    //                view.getPopularRecipes()
    //            case .failure(let error):
    //                print(error.localizedDescription)
    //            }
    //        }
    //    }
    func getRecipesWithMealType(mealType: String) {
        networkManager.getTenRecipesWithMealType(for: mealType) { result in
            switch result {
            case .success(let recipes):
                self.popularCategoryRecipes =  recipes
                guard let view = self.view else { return }
                print("Популярная категория: \(self.popularCategoryRecipes)")
                view.getPopularRecipes()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


