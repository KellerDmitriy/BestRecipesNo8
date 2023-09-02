//
//  TabBarPresenter.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 31.08.23.
//

import Foundation

final class TabBarPresenter {
    
    weak var view: TabBarView?
    private let router: TabBarRouterInput
    private let settingsManager: SettingsManagerProtocol

    init(router: TabBarRouterInput,settingsManager: SettingsManagerProtocol) {
        
        self.router = router
        self.settingsManager = settingsManager
    }
}
