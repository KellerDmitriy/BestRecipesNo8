//
//  RecipeRealmModel.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 09.09.2023.
//

import RealmSwift
import Foundation

class RecipeRealmModel: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var title: String = ""
    @Persisted var imageData: Data = Data()
    @Persisted var rating: String = ""
    @Persisted var time: Int = 0
    @Persisted var ingredients = List<Ingredients>()
    @Persisted var instuctionsLabel: String = ""
    @Persisted var timeSaving = Date()
}

class Ingredients: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var aisle: String = ""
    @Persisted var imageIngredientData: Data = Data()
    @Persisted var consistency: String = ""
    @Persisted var name: String = ""
    @Persisted var amount: Double = 0.0
    @Persisted var unit: String = ""
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
