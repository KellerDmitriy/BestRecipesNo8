//
//  CreateViewRouter.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 10.09.2023.
//

import UIKit

final class CreateViewRouter {
    
    weak var view: CreateViewController?
    
    func routeToCreateViewController() {
        let view = CreateVIewBuilder.createCreateModule()
        view.navigationController?.pushViewController(view, animated: true)
    }

}
