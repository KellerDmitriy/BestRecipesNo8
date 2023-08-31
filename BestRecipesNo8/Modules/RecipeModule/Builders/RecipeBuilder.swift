//
//  RecipeBuilder.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 28.08.23.
//

import UIKit

final class RecipeBuilder {
    static func createRecipeModule() -> UIViewController {
        let router = RecipeViewRouter()
        let settingsManager = SettingsManager()
        let presenter = RecipePresenter(router: router, settingsManager: settingsManager)
        let view = RecipeView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
