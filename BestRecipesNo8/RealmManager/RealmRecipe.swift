//
//  RealmRecipe.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 09.09.2023.
//

import RealmSwift
import Foundation

class RealmRecipe: Object {
    @Persisted var id : Int
    @Persisted var title : String
    @Persisted var image = Data()
}
