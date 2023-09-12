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
    var savedRecipesId: [Int] { get set }
    
    var searchedRecipes: [SearchRecipe] { get set}
    func fetchSearchedRecipe(with searchText: String)
    func updateRecipeInSavedRecipes(recipe: RecipeInfo)
    
    func seeAllButtonTapped()
    func addButtonTapped()
}

final class MainPresenter: MainPresenterProtocol {
 
    weak var view: MainScreenViewControllerProtocol?
    
    var dataService: DataServiceProtocol
    var trendingNowRecipes: [RecipeInfo] = []
    var popularCategoryRecipes: [RecipeInfo] = []
    var recentRecipe: [RecipeInfo] = []
    var networkManager = NetworkManager.shared
    var savedRecipesId: [Int] = []
    var searchedRecipes: [SearchRecipe] = []
    
    private let router: MainRouterInput
    
    //MARK: LifeCycle
    
    required init(view: MainScreenViewControllerProtocol, dataService: DataServiceProtocol, router: MainRouterInput) {
        self.dataService = dataService
        self.view = view
        self.router = router
        self.savedRecipesId = UserDefaults.standard.object(forKey: "savedRecipes") as? [Int] ?? []
    }
    
    func seeAllButtonTapped() {
        self.router.routeToSeeAllScreen(recipes: trendingNowRecipes)
    }
    
    func addButtonTapped() {
        // обновить массив savedRecipe UD!
        print("addButtonTapped")
    }
    
    func updateRecipeInSavedRecipes(recipe: RecipeInfo) {
        let contains = savedRecipesId.contains(where:  {$0 == recipe.id} )
        contains ? deleteRecipeInFavorites(recipe: recipe) :
        saveRecipeInFavorites(recipe: recipe)
    }
    
    func deleteRecipeInFavorites(recipe: RecipeInfo) {
        savedRecipesId.removeAll { $0 == recipe.id }
        UserDefaults.standard.set(savedRecipesId, forKey: "savedRecipes")
    }
    
    func saveRecipeInFavorites(recipe: RecipeInfo) {
        guard let id = recipe.id else { return }
        savedRecipesId.append(id)
        UserDefaults.standard.set(savedRecipesId, forKey: "savedRecipes")
    }
    
    func fetchSearchedRecipe(with searchText: String) {
           let group = DispatchGroup()
           group.enter()
           networkManager.getSearchRecipes(for: searchText) { [weak self] result in
               defer {
                   group.leave()
               }
               switch result {
               case .success(let recipes):
                   var models: [SearchRecipe] = []
                   recipes.results?.forEach({ recipe in
                       guard let title = recipe.title, let image = recipe.image else { return }
                       models.append(SearchRecipe(id: recipe.id, title: title, image: image))
                   })
                   self?.view?.configureSearchResults(models: models)
               case .failure(let error):
                   print(error)
               }
           }
           
           group.notify(queue: .main) {
           }
       }
   }


extension MainPresenter: PopularCategoryDelegate {
    func sectCell(recipe: RecipeInfo) {
#warning("CREATE Detail module here!")
        print(recipe)
        router.routeToRecipeDetailScreen(recipe: recipe)
    }
    

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
    
    func updateSavedRecipes(recipe: RecipeInfo) {
        self.updateRecipeInSavedRecipes(recipe: recipe)
        guard let view else { return }
        view.updatePopularCategory()
    }
    
    func isRecipeSaved(recipe: RecipeInfo) -> Bool {
        savedRecipesId.contains(where:  {$0 == recipe.id} )
    }
}




