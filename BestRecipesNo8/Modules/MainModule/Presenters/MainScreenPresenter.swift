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
    
    var router: RouterProtocol
    
    //MARK: LifeCycle 
    
    required init(view: MainScreenViewControllerProtocol, networkManager: NetworkManager, realmStoredManager: RealmStorageManager, router: RouterProtocol) {
        
        self.view = view
        self.networkManager = networkManager
        self.router = router
        self.savedRecipesId = Array(realmStoredManager.read().map { $0.id })
    }
    
    func seeAllButtonTapped() {
        self.router.routeToSeeAllScreen(recipes: trendingNowRecipes)
    }
    
    func seeAllRandomSectionButtonTapped() {
        self.router.routeToSeeAllScreen(recipes: randomRecipe)
    }
    
    func updateRecipeInSavedRecipes(recipe: RecipeInfo) {
        if isRecipeSaved(recipe: recipe) {
            realmStoredManager.deleteRecipeFromRealm(with: recipe.id)
        } else {
            let realmRecipe = RecipeRealmModel()
            realmRecipe.id = recipe.id
            realmRecipe.title = recipe.title ?? ""
            realmRecipe.image = recipe.image ?? ""
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



