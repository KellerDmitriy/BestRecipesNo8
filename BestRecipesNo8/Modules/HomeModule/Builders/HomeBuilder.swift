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
        let presenter = HomePresenter(router: router)
        let view = HomeView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
