//
//  CreateVIewBuilder.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 06.09.2023.
//

import UIKit

final class CreateVIewBuilder {
    
    static func createCreateModule() -> UIViewController {
        let router = CreateViewRouter()
        let presenter = CreateViewPresenter(router: router)
        let view = CreateViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
    
}
