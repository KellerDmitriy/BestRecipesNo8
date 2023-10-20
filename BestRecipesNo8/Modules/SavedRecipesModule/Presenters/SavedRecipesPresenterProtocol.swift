//
//  SavedRecipesPresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import Foundation
import RealmSwift

protocol SavedRecipesPresenterProtocol {
    var realmStorageManager: RealmStorageManager { get set }
    var savedRecipes: Results<RecipeRealmModel> { get set }
    
    var router: SavedRecipesRouterProtocol { get set }
    
    func loadData()
    func deleteRecipe(with index: Int)
    func deleteAllBarButtonTapped()
}
