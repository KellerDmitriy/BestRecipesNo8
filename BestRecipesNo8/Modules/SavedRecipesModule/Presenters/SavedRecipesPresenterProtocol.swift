//
//  SavedRecipesPresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import Foundation

protocol SavedRecipesPresenterProtocol {
    var realmStorageManager: RealmStorageManager { get set }
    var savedRecipes: [RecipeRealmModel] { get set }
    
    func loadData()
    func deleteRecipe(with index: Int)
    func deleteAllBarButtonTapped()
    func updateRecipe()

}
