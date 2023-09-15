//
//  HomeBuilder.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 14.09.23.
//

import UIKit

final class HomeBuilder {
    static func createHomeModule() -> UIViewController {
        let router = HomeViewRouter()
        let settingsManager = SettingsManager()
        let presenter = HomePresenter(router: router, settingsManager: settingsManager)
        let view = HomeView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
