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
        let view = OnboardingViewController()
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
    
    //    func routeToHomeScreen() {
    //  let view =
//            view.navigationController?.popToRootViewController(animated: true)
    //        }
    //    }
}
