//
//  HomePresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 23.10.2023.
//

import Foundation

protocol HomePresenterProtocol {
    var searchRouter: SearchRouterProtocol? { get set }
   
    var trendingNowRecipes: [RecipeProtocol] { get set }
    var popularCategories: [String] { get } 
    var popularCategoryRecipes: [RecipeProtocol] { get set }
    var randomRecipe: [RecipeProtocol] { get set }
    var teamMembers: [Team] { get set }
    
  
    var networkManager: NetworkManager { get set }
    var realmStoredManager: RealmStorageManager { get set }
    var router: HomeRouterProtocol { get set }
    
   // var searchController: AssemblyBuilderProtocol { get set }
    var savedRecipes: [RecipeRealmModel] { get set }
    var savedRecipesId: [Int] { get set }
    func updateRecipeInSavedRecipes(recipe: RecipeProtocol)
    
    func getCreateCompletion(with recipe: RecipeProtocol) -> (() -> ())
    func addButtonTapped(for recipe: RecipeProtocol)
    
    func seeAllButtonTapped(with sortOrder: Endpoint.SortOrder)
    
    func getRecipesWithMealType(mealType: String)
    func updateSavedRecipes(recipe: RecipeProtocol)
    func isRecipeSaved(recipe: RecipeProtocol) -> Bool
    func sectCell(recipe: RecipeProtocol)
}


