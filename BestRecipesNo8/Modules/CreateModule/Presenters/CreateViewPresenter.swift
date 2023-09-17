//
//  CreateViewPresenter.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 10.09.2023.
//

import Foundation

final class CreateViewPresenter: CreateRecipePresenterProtocol {
    
    weak var view: CreateViewProtocol?
    private let router: CreateViewRouter
    
    init(router: CreateViewRouter) {
        self.router = router
    }
    
}
