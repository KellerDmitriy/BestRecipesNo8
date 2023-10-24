//
//  SearchPresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 20.09.2023.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    
    var savedRecipesId: [Int] { get set }
    var searchedRecipes: [RecipeProtocol] { get set}
    var router: SearchRouterProtocol { get set }
    var realmStorageManager: RealmStorageManager { get set }
    var networkManager: NetworkManager { get set }
    
    func searchRecipes(with searchText: String)
}

protocol SearchModuleProtocol: AnyObject {
    func searchRecipes(with searchText: String)
    func updateSearchResults(with recipes: [RecipeProtocol])
}
