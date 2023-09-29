//
//  SearchPresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 20.09.2023.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    var savedRecipesId: [Int] { get set }
    var searchedRecipes: [SearchRecipe] { get set}
    
    init(view: SearchViewProtocol, networkManager: NetworkManager, realmStorageManager: RealmStorageManager, router: RouterProtocol)
    
    func searchRecipes(with searchText: String)
}
