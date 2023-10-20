//
//  SeeAllPresenter.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import Foundation

final class SeeAllPresenter: SeeAllPresenterProtocol {
    
    var view: SeeAllViewProtocol
    var networkManager: NetworkManager
    var realmStoredManager: RealmStorageManager
    var router: MainRouterProtocol
    
    let sortOrder: Endpoint.SortOrder

    //MARK: - Properties
    var seeAllRecipes: [RecipeProtocol]

    required init(
        view: SeeAllViewProtocol,
        networkManager: NetworkManager,
        realmStoredManager: RealmStorageManager,
        router: MainRouterProtocol,
        recipes: [RecipeProtocol],
        sortOrder: Endpoint.SortOrder
    ) {
        self.view = view
        self.networkManager = networkManager
        self.realmStoredManager = realmStoredManager
        self.router = router
        self.seeAllRecipes = recipes
        self.sortOrder = sortOrder
    }
}

extension SeeAllPresenter {

    func saveButtonTapped() {
//        func saveRecipeButtonTapped(_ sender: UIBarButtonItem) {
//            let imageRecipe = recipeDetailViewModel.recipeImage
//            let titleRecipe = recipeDetailViewModel.recipeName
//            switch sender.image {
//            case UIImage(systemName: "bookmark"):
//                sender.image = UIImage(systemName: "bookmark.fill")
//                AlertKitAPI.present(title: "Saved to favorites", subtitle: nil, icon: .done, style: .iOS16AppleMusic, haptic: .success)
//
//                recipeDetailViewModel.saveToRealm(id: recipeDetailViewModel.id, image: imageRecipe, title: titleRecipe)
//
//            case UIImage(systemName: "bookmark.fill"):
//                sender.image = UIImage(systemName: "bookmark")
//                AlertKitAPI.present(title: "Deleted from saved", subtitle: nil, icon: .error, style: .iOS16AppleMusic, haptic: .success)
//
//                recipeDetailViewModel.deleteObjectFromRealm(id: recipeDetailViewModel.id)
//            default: break
//            }
//        }
    }
}
