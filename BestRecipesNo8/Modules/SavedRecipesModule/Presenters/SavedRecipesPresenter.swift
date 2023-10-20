//
//  SavedRecipesPresenter.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import Foundation
import RealmSwift

final class SavedRecipesPresenter: SavedRecipesPresenterProtocol {

    //MARK: - Properties
    weak var view: SavedRecipesViewProtocol?
    var realmStorageManager = RealmStorageManager.shared
    var savedRecipesId: Int = 0
    var savedRecipes: Results<RecipeRealmModel> = RealmStorageManager.shared.realm.objects(RecipeRealmModel.self)
    var router: SavedRecipesRouterProtocol
    
    required init(view: SavedRecipesViewProtocol, router: SavedRecipesRouterProtocol, realmStorageManager: RealmStorageManager) {
        self.view = view
        self.router = router
        self.realmStorageManager = realmStorageManager
    }
    
    //MARK: - Realm BD

//    func saveRecipeButtonTapped(_ sender: UIBarButtonItem) {
//        let imageRecipe = recipeDetailViewModel.recipeImage
//        let titleRecipe = recipeDetailViewModel.recipeName
//        switch sender.image {
//        case UIImage(systemName: "bookmark"):
//            sender.image = UIImage(systemName: "bookmark.fill")
//            AlertKitAPI.present(title: "Saved to favorites", subtitle: nil, icon: .done, style: .iOS16AppleMusic, haptic: .success)
//
//            recipeDetailViewModel.saveToRealm(id: recipeDetailViewModel.id, image: imageRecipe, title: titleRecipe)
//
//        case UIImage(systemName: "bookmark.fill"):
//            sender.image = UIImage(systemName: "bookmark")
//            AlertKitAPI.present(title: "Deleted from saved", subtitle: nil, icon: .error, style: .iOS16AppleMusic, haptic: .success)
//
//            recipeDetailViewModel.deleteObjectFromRealm(id: recipeDetailViewModel.id)
//        default: break
//        }
//    }
    
    //MARK: - Methods
    
    func loadData() {
        realmStorageManager.read() { recipes in
            self.savedRecipes = recipes
        }
    }
    
    func deleteRecipe(with index: Int){
        realmStorageManager.deleteRecipeFromRealm(with: savedRecipesId)
    }
    
    func deleteAllBarButtonTapped() {
        realmStorageManager.deleteAll()
    }
}
