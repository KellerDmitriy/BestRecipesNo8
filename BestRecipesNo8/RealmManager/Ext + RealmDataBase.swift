//
//  Ext + RealmDataBase.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 10.09.2023.
//

import Foundation

extension RealmDataBase {
    func createCompletion(with recipe: RecipeProtocol) -> (() -> ()) {
        let closure = {
            if RealmDataBase.shared.isItemSaved(withId: recipe.id) {
                RealmDataBase.shared.deleteitem(withId: recipe.id)
            } else {
                RealmDataBase.shared.write(recipe: recipe)
            }
        }
        return closure
    }
}
