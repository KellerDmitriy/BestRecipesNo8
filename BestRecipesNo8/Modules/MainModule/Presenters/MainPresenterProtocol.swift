//
//  MainPresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 18.09.2023.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    var trendingNowRecipes: [RecipeInfo] { get set }
    var popularCategoryRecipes: [RecipeInfo] { get set }
    var randomRecipe: [RecipeInfo] { get set }
    var networkManager: NetworkManager { get set }
    var router: RouterProtocol { get set }
    var searchController: AssemblyBuilderProtocol { get set }
    var savedRecipes: [RecipeRealmModel] { get set }
    var savedRecipesId: [Int] { get set }
    var realmStoredManager: RealmStorageManager { get set }
    func isRecipeSaved(recipe: RecipeInfo) -> Bool
    func updateRecipeInSavedRecipes(recipe: RecipeInfo)
    func getCreateCompletion(with recipe: RecipeInfo) -> (() -> ())
    func addButtonTapped(for recipe: RecipeInfo)
    
    func seeAllButtonTapped()
    func seeAllRandomSectionButtonTapped()
    
    var searchedRecipes: [RecipeProtocol] { get set }
    func fetchSearchedRecipe(with searchText: String)
}
