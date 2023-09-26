//
//  Builder.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 31.08.2023.
//

import UIKit

protocol Builder {
    static func createMainScreenViewController() -> UIViewController
}

final class MainScreenBuilder: Builder {
    static func createMainScreenViewController() -> UIViewController {
        let view = MainScreenViewController()
        let router = MainViewRouter()
        let realmStoredManager = RealmStorageManager.shared
        let presenter = MainPresenter(view: view, realmStoredManager: realmStoredManager, router: router)
        presenter.view = view
        router.view = view
        view.presenter = presenter
        view.popularCategoryDelegate = presenter
        return view
    }
}
