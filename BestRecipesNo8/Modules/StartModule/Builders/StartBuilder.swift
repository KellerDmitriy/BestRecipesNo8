//
//  StartBuilder.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.08.2023.
//

import UIKit

final class StartBuilder {
    static func createStartModule() -> UIViewController {
        let router = StartViewRouter()
        let settingsManager = SettingsManager()
        let presenter = StartPresenter(router: router, settingsManager: settingsManager)
        let view = StartView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
