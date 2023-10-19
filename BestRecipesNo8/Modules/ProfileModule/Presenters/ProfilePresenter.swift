//
//  ProfilePresenter.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 1.09.23.
//

import Foundation

final class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    private let router: ProfileRouterProtocol

    init(view: ProfileViewProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.router = router

    }
}

