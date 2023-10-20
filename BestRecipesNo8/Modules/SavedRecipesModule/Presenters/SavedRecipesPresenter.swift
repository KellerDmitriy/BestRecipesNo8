//
//  SavedRecipesPresenter.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import Foundation
import RealmSwift

final class SavedRecipesPresenter: SavedRecipesPresenterProtocol {
    
    //MARK: - Properties
    weak var view: SavedRecipesViewProtocol?
    var realmStorageManager = RealmStorageManager.shared
    
    var savedRecipes: Results<RecipeRealmModel> = RealmStorageManager.shared.realm.objects(RecipeRealmModel.self)
    var router: SavedRecipesRouterProtocol
    
    required init(view: SavedRecipesViewProtocol, router: SavedRecipesRouterProtocol, realmStorageManager: RealmStorageManager) {
        self.view = view
        self.router = router
        self.realmStorageManager = realmStorageManager
    }
    
    //MARK: - Realm BD Methods
    
    func loadData() {
        realmStorageManager.read() { recipes in
            self.savedRecipes = recipes
        }
    }
    
    func deleteRecipe(with index: Int) {
        realmStorageManager.deleteRecipeFromRealm(with: index)
    }
    
    func deleteAllBarButtonTapped() {
        realmStorageManager.deleteAll()
    }
}
