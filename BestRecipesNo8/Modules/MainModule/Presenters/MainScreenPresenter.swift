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
    
    var trendingNowRecipes: [RecipeProtocol] = []
    var popularCategoryRecipes: [RecipeProtocol] = []
    var randomRecipe: [RecipeProtocol] = []
    
    var savedRecipesId: [Int] = []
    var savedRecipes: [RecipeRealmModel] = []
    
    var searchedRecipes: [RecipeProtocol] = []
    
    var router: MainRouterProtocol
    let assemblyBuilder = AssemblyBuilder()
    
    
    //MARK: LifeCycle
    
    required init(view: MainScreenViewControllerProtocol, networkManager: NetworkManager, realmStoredManager: RealmStorageManager, router: MainRouterProtocol) {
        
        self.view = view
        self.networkManager = networkManager
        self.realmStoredManager = realmStoredManager
        self.router = router
        // self.savedRecipesId = Array(realmStoredManager.read(completion: ).map { $0.id })
    }
    
    //MARK: SeeAll Methods
    func seeAllButtonTapped(with sortOrder: Endpoint.SortOrder) {
        switch sortOrder {
        case .trendingNow:
            router.routeToSeeAllScreen(recipes: trendingNowRecipes, sortOrder: sortOrder)
        case .random:
            router.routeToSeeAllScreen(recipes: randomRecipe, sortOrder: sortOrder)
        }
    }
    
    
    //MARK: DB CRUD Methods
    func updateRecipeInSavedRecipes(recipe: RecipeProtocol) {
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
    
    func deleteRecipeInFavorites(recipe: RecipeProtocol) {
        let id = recipe.id
        savedRecipesId.removeAll { $0 == id }
        realmStoredManager.deleteRecipeFromRealm(with: id)
    }
    
    func saveRecipeInFavorites(recipe: RecipeProtocol) {
        let id = recipe.id
        let realmRecipe = RecipeRealmModel(value: ["id": id])
        realmStoredManager.save(savedRecipes)
    }
}

extension MainPresenter: PopularCategoryDelegate {
    func sectCell(recipe: RecipeProtocol) {
        router.routeToDetailScreen(recipe: recipe)
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
    
    func updateSavedRecipes(recipe: RecipeProtocol) {
        self.updateRecipeInSavedRecipes(recipe: recipe)
        guard let view else { return }
        view.updatePopularCategory()
    }
    
    func isRecipeSaved(recipe: RecipeProtocol) -> Bool {
        return realmStoredManager.isItemSaved(withId: recipe.id )
    }
    
    func getCreateCompletion(with recipe: RecipeProtocol) -> (() -> ()) {
        return realmStoredManager.createCompletion(with: recipe)
    }
    
    func addButtonTapped(for recipe: RecipeProtocol) {
        if isRecipeSaved(recipe: recipe) {
            deleteRecipeInFavorites(recipe: recipe)
        } else {
            saveRecipeInFavorites(recipe: recipe)
        }
    }
}

 //MARK: Search  method
extension MainPresenter {
    
    func fetchSearchedRecipe(with searchText: String) {
        //
    }
    
}


