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
    
    private let router: SavedRecipesRouterInput
    
    init(router: SavedRecipesRouterInput) {
        
        self.router = router
    }
    
    //MARK: - UserDefaults
    var defaults: UserDefaults {
        get { return UserDefaults.standard }
        set { newValue.set(savedRecipes, forKey: "savedRecipes") }
    }
    
    var savedRecipes: [RecipeInfo] {
        get { return defaults.array(forKey: "savedRecipes") as? [RecipeInfo] ?? [] }
        set {
            defaults.set(newValue, forKey: "savedRecipes")
        }
    }
    
    //MARK: - Methods
    func removeRecipe(at index: Int) {
        savedRecipes.remove(at: index)
        defaults.set(savedRecipes, forKey: "savedRecipes")
    }
}
