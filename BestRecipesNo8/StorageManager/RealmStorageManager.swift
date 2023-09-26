//
//  RealmStorageManager.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 09.09.2023.
//

import RealmSwift
import Foundation

class RealmStorageManager {
    // MARK: - Properties
    static let shared = RealmStorageManager()
    
    let realm: Realm
    
    // MARK: - Initialization
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    // MARK: - Public methods
    
    func save(_ recipes: [RecipeRealmModel]) {
        write {
            realm.add(recipes)
        }
    }
    
    func save<T: RecipeProtocol>(recipe: T) {
        let realmRecipe = RecipeRealmModel()
        realmRecipe.id = recipe.id
        if let title = recipe.title {
            realmRecipe.title = title
        }
        if let image = recipe.image {
            realmRecipe.image = image
        }
        write {
            realm.add(realmRecipe)
        }
    }
    
    func isItemSaved(withId id: Int) -> Bool {
        let itemsWithId = realm.objects(RecipeRealmModel.self).filter("id = %@", id)
        return !itemsWithId.isEmpty
    }
    
    func read() -> [RecipeRealmModel] {
        let recipes = realm.objects(RecipeRealmModel.self)
        return Array(recipes)
    }
    
    
    func deleteRecipeFromRealm(with id: Int) {
        if let objectToDelete = realm.objects(RecipeRealmModel.self).filter("id == \(id)").first {
            write {
                realm.delete(objectToDelete)
            }
        }
    }
    
    func deleteAll() {
        write {
            let allRecipes = realm.objects(RecipeRealmModel.self)
            realm.delete(allRecipes)
        }
    }
    
    // MARK: - Private methods
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
    
}
