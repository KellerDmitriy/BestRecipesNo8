//
//  TabBarBuilder.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 31.08.23.
//

import UIKit

final class TabBarBuilder {
    static func createTabBarModule() -> UIViewController {
        let router = TabBarViewRouter()
        let settingsManager = SettingsManager()
        let presenter = TabBarPresenter(router: router, settingsManager: settingsManager)
        let view = TabBarView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
