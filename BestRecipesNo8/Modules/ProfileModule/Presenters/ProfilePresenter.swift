//
//  ProfilePresenter.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 1.09.23.
//

import Foundation

final class ProfilePresenter {
    
    weak var view: ProfileViewProtocol?
    private let router: ProfileRouterProtocol

    init(router: ProfileRouterProtocol) {
        self.router = router

    }
}

