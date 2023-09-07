//
//  ProfilePresenter.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 1.09.23.
//

import Foundation

final class ProfilePresenter {
    
    weak var view: ProfileViewInput?
    private let router: ProfileRouterInput

    init(router: ProfileRouterInput) {
        self.router = router

    }
}

