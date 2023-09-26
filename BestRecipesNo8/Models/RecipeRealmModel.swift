//
//  RecipeRealmModel.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 09.09.2023.
//

import RealmSwift
import Foundation

class RecipeRealmModel: Object {
    @Persisted var id: Int
    @Persisted var title: String
    @Persisted var image: String
    @Persisted var rating: Int?
    @Persisted var time: Int?
}

class RecipeInfoRealm: Object {
    @Persisted var id = UUID()
    @Persisted var title = ""
    @Persisted var serves = ""
    @Persisted var cookTime = ""
    @Persisted var imageData = Data()
    @Persisted var ingredients = Map<String, String>()
    
    convenience init(id: UUID = UUID(), title: String, serves: String, cookTime: String, imageData: Data, ingredients: [String: String]) {
        self.init()
        self.id = id
        self.title = title
        self.serves = serves
        self.cookTime = cookTime
        self.imageData = imageData
        self.ingredients.removeAll()
        
        for (key, value) in ingredients {
            self.ingredients[key] = value
        }
    }
}
