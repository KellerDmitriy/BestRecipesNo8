//
//  MainViewRouter.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 04.09.2023.
//

import UIKit

final class MainViewRouter: MainRouterInput {
    
    weak var view: UIViewController?
    
    func routeToSeeAllScreen() {
        let view = SeeAllBuilder.createSeeAllModule()
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
}
