//
//  SavedRecipesPresenter.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import Foundation

final class SavedRecipesPresenter: SavedRecipesViewOutput {

    
    
    //MARK: - Properties
    weak var view: SavedRecipesViewInput?
    private var savedRecipesId: [Int] = []
    internal var savedRecipes: [RecipeInfo] = []
    private let router: SavedRecipesRouterInput
    
    init(router: SavedRecipesRouterInput) {
        self.router = router
    }
    
    //MARK: - UserDefaults
    var defaults: UserDefaults {
        get { return UserDefaults.standard }
        set { newValue.set(savedRecipes, forKey: "savedRecipes") }
    }
    
    
    //MARK: - Methods
    func removeRecipe(at index: Int) {
        savedRecipes.remove(at: index)
        defaults.set(savedRecipes, forKey: "savedRecipes")
    }
    
    func updateRecipe() {
        if let savedRecipesId = UserDefaults.standard.object(forKey: "savedRecipes") as? [Int] {
            NetworkManager.shared.getRecipeInformationBulk(for: savedRecipesId) { result in
                switch result {
                case .success(let recipes):
                    self.savedRecipes = recipes
                    self.view?.openSavedRecipes()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
