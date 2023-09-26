//
//  MainPresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 18.09.2023.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    var view : MainScreenViewControllerProtocol? { get set }
    var trendingNowRecipes: [RecipeInfo] { get set }
    var popularCategoryRecipes: [RecipeInfo] { get set }
    var recentRecipe: [RecipeInfo] { get set }
    var networkManager: NetworkManager { get set }
    
    var realmStoredManager: RealmStorageManager { get set }
    var savedRecipesId: [Int] { get set }
    var savedRecipes: [RecipeRealmModel] { get set }
    
    func isRecipeSaved(recipe: RecipeInfo) -> Bool
    func updateRecipeInSavedRecipes(recipe: RecipeInfo)
    func getCreateCompletion(with recipe: RecipeInfo) -> (() -> ())
    
    var searchedRecipes: [SearchRecipe] { get set}
    func fetchSearchedRecipe(with searchText: String)
    
    func seeAllButtonTapped()
    func seeAllRecipeSectionButtonTapped()
    func addButtonTapped(for recipe: RecipeInfo)
}
