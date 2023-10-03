//
//  SeeAllPresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import Foundation

protocol SeeAllPresenterProtocol: AnyObject {
    var seeAllRecipes: [RecipeProtocol] { get }
    var router: RouterProtocol? { get set }
    
    init(
        view: SeeAllViewProtocol,
        networkManager: NetworkManager,
        realmStoredManager: RealmStorageManager,
        router: RouterProtocol,
        recipes: [RecipeProtocol]
    )
    
    func cellTapped()
    func saveButtonTapped()
}
