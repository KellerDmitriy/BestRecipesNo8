//
//  SeeAllPresenter.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import Foundation

final class SeeAllPresenter: SeeAllPresenterProtocol {

    //MARK: - Properties
    weak var view: SeeAllViewProtocol?
    let networkManager: NetworkManager?
    let realmStoredManager: RealmStorageManager?
    var router: RouterProtocol?
    var seeAllRecipes: [RecipeInfo]

    required init(view:SeeAllViewProtocol, networkManager: NetworkManager, realmStoredManager: RealmStorageManager, router: RouterProtocol, recipes: [RecipeInfo]) {
        self.networkManager = networkManager
        self.realmStoredManager = realmStoredManager
        self.router = router
        self.seeAllRecipes = recipes
    }
}

extension SeeAllPresenter {
    func cellTapped() {
        //
    }
    
    func saveButtonTapped() {
        //
    }
}
