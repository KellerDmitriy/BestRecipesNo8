//
//  ProfileBuilder.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 1.09.23.
//

import UIKit

final class ProfileBuilder {
    static func createProfileModule() -> UIViewController {
        let router = ProfileViewRouter()
        let presenter = ProfilePresenter(router: router)
        let view = ProfileView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
