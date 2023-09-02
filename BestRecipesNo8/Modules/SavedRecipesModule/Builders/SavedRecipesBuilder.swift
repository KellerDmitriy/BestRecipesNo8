//
//  SavedRecipesBuilder.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import UIKit

final class SavedRecipesBuilder {
    static func createSavedRecipesModule() -> UIViewController {
        let router = SavedRecipesViewRouter()
        let settingsManager = SettingsManager()
        let presenter = SavedRecipesPresenter(router: router, settingsManager: settingsManager)
        let view = SavedRecipesView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
