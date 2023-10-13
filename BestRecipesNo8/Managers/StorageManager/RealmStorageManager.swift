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
    let imageManager = ImageManager.shared
    let realm: Realm
    var items: Results<RecipeRealmModel>!
    
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
    
    func write<T: RecipeProtocol>(recipe: T) {
        let realmRecipe = RecipeRealmModel()
        realmRecipe.id = recipe.id
        if let title = recipe.title {
            realmRecipe.title = title
        }
        if let rating = recipe.rating {
            realmRecipe.rating = rating
        }
        if let time = recipe.readyInMinutes {
            realmRecipe.time = time
        }
        
        if let image = recipe.image {
            guard let imageURL = URL(string: image) else { return }
            imageManager.fetchImageData(from: imageURL) { [weak self] imageData, error in
                realmRecipe.imageData = imageData
                DispatchQueue.main.async {
                    self?.write {
                        self?.realm.add(realmRecipe)
                    }
                }
            }
        }
    }
    
    func isItemSaved(withId id: Int) -> Bool {
        let itemsWithId = realm.objects(RecipeRealmModel.self).filter("id = %@", id)
        return !itemsWithId.isEmpty
    }
    
    func read(completion: @escaping (Results<RecipeRealmModel>) -> ()) {
        items = realm.objects(RecipeRealmModel.self)
        completion(items)
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
