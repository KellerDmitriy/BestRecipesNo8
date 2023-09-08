//
//  StorageManager.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 06.09.2023.
//

import RealmSwift

import UIKit

class StorageManager {
    
    static let shared = StorageManager()
    
    private let realm = try! Realm()
    private var recipes: Results<RecipeInfoRealm>!
    
    private init() {}
    
    // MARK: - Methods
    
    //    func save(recipes: RecipesRealm) {
    //        try! realm.write {
    //            realm.add(recipes)
    //        }
    //    }
    
    func saveData<T: Object>(object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object)
            }
        } catch let error as NSError {
            print("Error saving data to Realm: \(error.localizedDescription)")
        }
        
    }
    
    func fetchData<T: Object>(_ objectType: T.Type) -> Results<T>? {
        do {
            let realm = try Realm()
            let objects = realm.objects(objectType)
            return objects
        } catch let error as NSError {
            print("Error fetching data from Realm: \(error.localizedDescription)")
            return nil
        }
    }
    
    func save(recipes: [RecipeInfoRealm]) {
        try! realm.write {
            realm.add(recipes)
        }
    }
    
    func save(recipe: RecipeInfoRealm) {
        try! realm.write {
            realm.add(recipe)
        }
    }
    
    func read(completion: @escaping(Results<RecipeInfoRealm>) -> Void) {
        recipes = realm.objects(RecipeInfoRealm.self)
        completion(recipes)
    }
    
}
