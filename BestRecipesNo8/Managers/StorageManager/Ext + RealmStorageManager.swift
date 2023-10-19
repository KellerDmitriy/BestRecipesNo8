//
//  Ext + RealmStorageManager.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 10.09.2023.
//

import Foundation

extension RealmStorageManager {
    
    func createCompletion(with recipe: RecipeProtocol) -> (() -> ()) {
        let closure = {
            if RealmStorageManager.shared.isItemSaved(withId: recipe.id) {
                RealmStorageManager.shared.deleteRecipeFromRealm(with: recipe.id)
            } else {
                RealmStorageManager.shared.write(recipe: recipe)
            }
        }
        return closure
    }
}
