//
//  ProfilePresenter.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 1.09.23.
//

import Foundation

final class ProfilePresenter {
    
    weak var view: ProfileViewInput?
    private let router: ProfileRouterInput
    private let settingsManager: SettingsManagerProtocol

    init(router: ProfileRouterInput,settingsManager: SettingsManagerProtocol) {
        
        self.router = router
        self.settingsManager = settingsManager
    }
}

