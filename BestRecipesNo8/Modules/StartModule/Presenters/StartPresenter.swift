//
//  StartPresenter.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.08.2023.
//

import Foundation

final class StartPresenter {
    
    weak var view: StartViewInput?
    private let router: StartRouterInput
    private let settingsManager: SettingsManagerProtocol

    init(router: StartRouterInput, settingsManager: SettingsManagerProtocol) {
        
        self.router = router
        self.settingsManager = settingsManager
    }
}

extension StartPresenter: StartViewOutput {
    func startButtonTapped() {
        self.router.routeToOnboardingScreen()
    }
}
