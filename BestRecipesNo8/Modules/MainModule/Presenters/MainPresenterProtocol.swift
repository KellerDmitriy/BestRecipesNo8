//
//  MainPresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 18.09.2023.
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
