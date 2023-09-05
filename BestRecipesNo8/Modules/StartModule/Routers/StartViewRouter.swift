//
//  StartViewRouter.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.08.2023.
//

import UIKit

final class StartViewRouter: StartRouterInput {
    
    weak var view: UIViewController?
    
    func routeToOnboardingScreen() {
        let view = StartBuilder.showOnboardingPages()
        self.view?.navigationController?.setViewControllers([view], animated: true)
    }
    
    func routeToHomeScreen() {
        let tabbarVC = CustomTabBar()
        self.view?.navigationController?.setViewControllers([tabbarVC], animated: true)
    }
}
