//
//  SavedRecipesPresenter.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import Foundation

final class SavedRecipesPresenter {
    
    weak var view: SavedRecipesViewInput?
    private let router: SavedRecipesRouterInput
    private let settingsManager: SettingsManagerProtocol

    init(router: SavedRecipesRouterInput,settingsManager: SettingsManagerProtocol) {
        
        self.router = router
        self.settingsManager = settingsManager
    }
}
