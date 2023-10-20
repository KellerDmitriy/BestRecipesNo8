//
//  MainPresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 18.09.2023.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    var trendingNowRecipes: [RecipeProtocol] { get set }
    var popularCategoryRecipes: [RecipeProtocol] { get set }
    var randomRecipe: [RecipeProtocol] { get set }
    
    var networkManager: NetworkManager { get set }
    var realmStoredManager: RealmStorageManager { get set }
    var router: MainRouterProtocol { get set }
    
   // var searchController: AssemblyBuilderProtocol { get set }
    var savedRecipes: [RecipeRealmModel] { get set }
    var savedRecipesId: [Int] { get set }
    func isRecipeSaved(recipe: RecipeProtocol) -> Bool
    func updateRecipeInSavedRecipes(recipe: RecipeProtocol)
    func getCreateCompletion(with recipe: RecipeProtocol) -> (() -> ())
    func addButtonTapped(for recipe: RecipeProtocol)
    
    func seeAllButtonTapped(with sortOrder: Endpoint.SortOrder)
    
    var searchedRecipes: [RecipeProtocol] { get set }
    func fetchSearchedRecipe(with searchText: String)
}
