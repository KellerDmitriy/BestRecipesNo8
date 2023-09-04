//
//  SeeAllBuilder.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//


import UIKit

final class SeeAllBuilder {
    static func createSeeAllModule() -> UIViewController {
        let router = SeeAllViewRouter()
    
        let presenter = SeeAllPresenter(router: router)
        let view = SeeAllViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}

