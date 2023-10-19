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
    var router: MainRouterProtocol
    
    let sortOrder: Endpoint.SortOrder

    //MARK: - Properties
    var seeAllRecipes: [RecipeProtocol]

    required init(
        view: SeeAllViewProtocol,
        networkManager: NetworkManager,
        realmStoredManager: RealmStorageManager,
        router: MainRouterProtocol,
        recipes: [RecipeProtocol],
        sortOrder: Endpoint.SortOrder
    ) {
        self.view = view
        self.networkManager = networkManager
        self.realmStoredManager = realmStoredManager
        self.router = router
        self.seeAllRecipes = recipes
        self.sortOrder = sortOrder
    }
}

extension SeeAllPresenter {

    func saveButtonTapped() {
        //
    }
}
