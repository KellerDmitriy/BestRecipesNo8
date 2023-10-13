//
//  SeeAllPresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import Foundation

protocol SeeAllPresenterProtocol: AnyObject {
    var view: SeeAllViewProtocol { get set }
    var sortion: Endpoint.Sortion { get }
 
    var seeAllRecipes: [RecipeProtocol] { get set }

    var networkManager: NetworkManager { get set }
    var realmStoredManager: RealmStorageManager { get set }
    var router: RouterProtocol { get set }
    
    func saveButtonTapped()
    
}
