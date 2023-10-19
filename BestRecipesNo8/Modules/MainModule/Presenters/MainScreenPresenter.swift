//
//  MainScreenPresenter.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 31.08.2023.
//

import Foundation

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainScreenViewControllerProtocol?
    
    var networkManager = NetworkManager.shared
    var realmStoredManager = RealmStorageManager.shared
    
    var trendingNowRecipes: [RecipeInfo] = []
    var popularCategoryRecipes: [RecipeInfo] = []
    var randomRecipe: [RecipeInfo] = []
    
    var savedRecipesId: [Int] = []
    var savedRecipes: [RecipeRealmModel] = []
    
//    var searchController: AssemblyBuilderProtocol
    var searchedRecipes: [RecipeProtocol] = []
    
    var router: MainRouterProtocol
    
    //MARK: LifeCycle
    
    required init(view: MainScreenViewControllerProtocol, networkManager: NetworkManager, realmStoredManager: RealmStorageManager, router: MainRouterProtocol) {
        
       // self.searchController = searchController
        self.view = view
        self.networkManager = networkManager
        self.realmStoredManager = realmStoredManager
        self.router = router
       // self.savedRecipesId = Array(realmStoredManager.read(completion: ).map { $0.id })
    }
    
    //MARK: SeeAll Methods
    func seeAllButtonTapped(with sortion: Endpoint.SortOrder) {
        switch sortion {
        case .trendingNow:
            router.routeToSeeAllScreen(recipes: trendingNowRecipes, sortOrder: sortion)
        case .random:
            router.routeToSeeAllScreen(recipes: randomRecipe, sortOrder: sortion)
        }
    }
    
    
    //MARK: Search Methods
    func fetchSearchedRecipe(with searchText: String) {
        networkManager.getSearchRecipes(for: searchText) { [weak self] result in
            switch result {
            case .success(let recipes):
                var models: [SearchRecipe] = []
                recipes.results?.forEach({ recipe in
                    guard let title = recipe.title, let image = recipe.image, let readyInMinutes = recipe.readyInMinutes  else { return }
                    models.append(SearchRecipe(id: recipe.id, title: title, image: image, readyInMinutes: readyInMinutes))
                })
                self?.view?.configureSearchResults(models: models)
        
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: DB CRUD Methods
    func updateRecipeInSavedRecipes(recipe: RecipeInfo) {
        if isRecipeSaved(recipe: recipe) {
            realmStoredManager.deleteRecipeFromRealm(with: recipe.id)
        } else {
            let realmRecipe = RecipeRealmModel()
            realmRecipe.id = recipe.id
            realmRecipe.title = recipe.title ?? ""
           // realmRecipe.imageData = recipe.image
            realmStoredManager.save(savedRecipes)
        }
    }
    
    func deleteRecipeInFavorites(recipe: RecipeInfo) {
        let id = recipe.id
        savedRecipesId.removeAll { $0 == id }
        realmStoredManager.deleteRecipeFromRealm(with: id)
    }
    
    func saveRecipeInFavorites(recipe: RecipeInfo) {
        let id = recipe.id
        let realmRecipe = RecipeRealmModel(value: ["id": id])
        realmStoredManager.save(savedRecipes)
    }
}

extension MainPresenter: PopularCategoryDelegate {
    func sectCell(recipe: RecipeInfo) {
        router.routeToDetailRecipeScreen(recipe: recipe)
        print(recipe)
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
        return realmStoredManager.isItemSaved(withId: recipe.id )
    }
    
    func getCreateCompletion(with recipe: RecipeInfo) -> (() -> ()) {
        return realmStoredManager.createCompletion(with: recipe)
    }
    
    func addButtonTapped(for recipe: RecipeInfo) {
        if isRecipeSaved(recipe: recipe) {
            deleteRecipeInFavorites(recipe: recipe)
        } else {
            saveRecipeInFavorites(recipe: recipe)
        }
    }
}



