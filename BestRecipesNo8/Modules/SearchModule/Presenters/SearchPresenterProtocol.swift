//
//  SearchPresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 20.09.2023.
//

import Foundation

protocol SearchPresenterProtocol {
    var networkManager: NetworkManager? { get set }
    var view: SearchViewProtocol? { get set }
    var route: SearchRouterProtocol? { get set }
    var savedRecipesId: [Int] { get set }
    var searchedRecipes: [SearchRecipe] { get set}
    
    func searchRecipes(with searchText: String)
}
