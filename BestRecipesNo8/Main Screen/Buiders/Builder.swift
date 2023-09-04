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
        let dataService = DataService()
        let router = MainViewRouter()
        let presenter = MainPresenter(view: view, dataService: dataService, router: router)
        view.presenter = presenter
        view.popularCategoryDelegate = presenter
        return view
    }
}
