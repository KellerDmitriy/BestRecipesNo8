//
//  CreateViewBuilder.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 10.09.2023.
//

import UIKit

final class CreateViewBuilder {
    
    static func createCreateModule() -> UIViewController {
        let router = CreateViewRouter()
        let presenter = CreateViewPresenter(router: router)
        let view = CreateViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
    
}
