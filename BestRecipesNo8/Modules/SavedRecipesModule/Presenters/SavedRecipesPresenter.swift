//
//  SavedRecipesPresenter.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import Foundation

final class SavedRecipesPresenter: SavedRecipesPresenterProtocol {
 
    //MARK: - Properties
    weak var view: SavedRecipesViewProtocol?
    var savedRecipes: [RecipeRealmModel] = []
    var realmStorageManager = RealmStorageManager.shared
    private var savedRecipesId: [Int] = []
    private let router: SavedRecipesRouterInput
    
    init(router: SavedRecipesRouterInput, realmStorageManager: RealmStorageManager) {
        self.router = router
        
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
        realmStorageManager.read()
        
    }
    

    func deleteRecipe(with index: Int) {
        //
    }
    
    func deleteAllBarButtonTapped() {
        realmStorageManager.deleteAll()
    }
    
    func updateRecipe() {
        if let savedRecipesId = UserDefaults.standard.object(forKey: "savedRecipes") as? [Int] {
            NetworkManager.shared.getRecipeInformationBulk(for: savedRecipesId) { result in
                switch result {
                case .success(let recipes):
                  //  self.savedRecipes = recipes
                    self.view?.openSavedRecipes()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
