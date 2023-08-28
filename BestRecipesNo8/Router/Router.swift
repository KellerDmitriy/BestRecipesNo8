//
//  Router.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 27.08.2023.
//

import UIKit

protocol RouterOutputProtocol: AnyObject {
    
    var navigationVC: UINavigationController? {get set}
    var moduleBuilder: ModuleBuilderProtocol? {get set}
    
}

protocol RouterProtocol: RouterOutputProtocol {
    
    func showStartScreenController()
    
}

class Router: RouterProtocol {
    
    var navigationVC: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(navigationVC: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        
        self.navigationVC = navigationVC
        self.moduleBuilder = moduleBuilder
        
    }
    
    func showStartScreenController() {
        if let navigationVC = navigationVC {
            guard let startVC = moduleBuilder?.createStartScreenModule(router: self) else { return }
            navigationVC.viewControllers = [startVC]
        }
    }
    
}
