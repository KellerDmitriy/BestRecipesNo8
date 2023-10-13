//
//  SeeAllPresenter.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import Foundation

final class SeeAllPresenter: SeeAllPresenterProtocol {
    
    var view: SeeAllViewProtocol
    var networkManager: NetworkManager
    var realmStoredManager: RealmStorageManager
    var router: RouterProtocol
    
    let sortion: Endpoint.Sortion

    //MARK: - Properties
    var seeAllRecipes: [RecipeProtocol]

    required init(view: SeeAllViewProtocol, networkManager: NetworkManager, realmStoredManager: RealmStorageManager, router: RouterProtocol, recipes: [RecipeProtocol], sortion: Endpoint.Sortion ) {
        self.view = view
        self.networkManager = networkManager
        self.realmStoredManager = realmStoredManager
        self.router = router
        self.seeAllRecipes = recipes
        self.sortion = sortion
    }
}

extension SeeAllPresenter {

    func saveButtonTapped() {
        //
    }
}
