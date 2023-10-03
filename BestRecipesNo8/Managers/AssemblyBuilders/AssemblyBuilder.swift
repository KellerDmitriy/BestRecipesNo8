//
//  AssemblyBuilder.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.09.2023.
//

import UIKit

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkManager = NetworkManager.shared
        let realmStoredManager = RealmStorageManager.shared
        let presenter = MainPresenter(view: view, networkManager: networkManager, realmStoredManager: realmStoredManager, router: router)
        presenter.view = view
        view.presenter = presenter
        view.popularCategoryDelegate = presenter
        return view
    }
    
    func createSearchModule(router: RouterProtocol) -> UIViewController {
        let view = SearchVC()
        let networkManager = NetworkManager.shared
        let realmStoredManager = RealmStorageManager.shared
        let presenter = SearchPresenter(view: view, networkManager: networkManager, realmStorageManager: realmStoredManager, router: router)
        view.presenter = presenter
        return view
    }
    
    func createSeeAllModule(recipes: [RecipeProtocol], router: RouterProtocol) -> UIViewController {
        let view = SeeAllViewController()
        let networkManager = NetworkManager.shared
        let realmStoredManager = RealmStorageManager.shared

        let presenter = SeeAllPresenter( view: view, networkManager: networkManager, realmStoredManager: realmStoredManager, router: router, recipes: recipes)
        view.presenter = presenter
        return view
    }
    
    func createRecipeDetailModule(recipe: RecipeProtocol, router: RouterProtocol) -> UIViewController {
        let view = RecipeView()
        let presenter = RecipeDetailPresenter(view: view, recipe: recipe)
        view.presenter = presenter
        return view
    }
    
    func createProfileModule(router: RouterProtocol) -> UIViewController {
        let view = ProfileView()
        let presenter = ProfilePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createSavedRecipesModule(router: RouterProtocol) -> UIViewController {
        let view = SavedRecipesView()
        let realmStoredManager = RealmStorageManager.shared
        let presenter = SavedRecipesPresenter(view: view, router: router, realmStorageManager: realmStoredManager)
        view.presenter = presenter
        return view
    }
    
    func createCreateModule(router: RouterProtocol) -> UIViewController {
        let view = CreateViewController()
        let presenter = CreateViewPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}

