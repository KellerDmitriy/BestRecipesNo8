//
//  AssemblyBuilder.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.09.2023.
//

import UIKit

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createTabBar() -> CustomTabBarController {
        let tabBar = CustomTabBarController()
        return tabBar
    }
    
    //MARK: - Main module
    func createMainRouter() -> MainRouterProtocol {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(title: nil, image: .main, tag: 0)
        navigationController.tabBarItem.selectedImage = .mainSelect
        let router = MainRouter(
            navigationController: navigationController,
            assemblyBuilder: self
        )
        router.setupInitial()
        return router
    }
    
    func createMainModule(router: MainRouterProtocol) -> MainViewController {
        let viewController = MainViewController()
        let networkManager = NetworkManager.shared
        let realmStoredManager = RealmStorageManager.shared
        let presenter = MainPresenter(
            
            view: viewController,
            
            networkManager: networkManager,
            
            realmStoredManager: realmStoredManager,
            
            router: router
        
        )
        presenter.view = viewController
        viewController.presenter = presenter
        viewController.popularCategoryDelegate = presenter
        return viewController
    }
    
    func createSeeAllModule(
        recipes: [RecipeProtocol],
        router: MainRouter,
        sortOrder: Endpoint.SortOrder
    ) -> SeeAllViewController {
        
        let viewController = SeeAllViewController()
        let networkManager = NetworkManager.shared
        let realmStoredManager = RealmStorageManager.shared

        let presenter = SeeAllPresenter(
            view: viewController,
            networkManager: networkManager,
            realmStoredManager: realmStoredManager,
            router: router,
            recipes: recipes,
            sortOrder: sortOrder
        )
        viewController.presenter = presenter
        return viewController
    }
    
    //MARK: - SavedRecipes module
    func createSavedRecipesRouter() -> SavedRecipesRouterProtocol {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(title: nil, image: .bookmark, tag: 1)
        navigationController.tabBarItem.selectedImage = .bookmarkSelect
        
        let router = SavedRecipeRouter(
            navigationController: navigationController,
            assemblyBuilder: self
        )
        router.setupInitial()
        return router
    }
    
    func createSavedRecipesModule(router: SavedRecipesRouterProtocol) -> SavedRecipesViewController {
        let viewController = SavedRecipesViewController()
        let realmStoredManager = RealmStorageManager.shared
        let presenter = SavedRecipesPresenter(
            view: viewController,
            router: router,
            realmStorageManager: realmStoredManager
        )
        viewController.presenter = presenter
        return viewController
    }
    
    //MARK: - Search module
    func createSearchRouter() -> SearchRouterProtocol {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(title: nil, image: .notification, tag: 3)
        navigationController.tabBarItem.selectedImage = .notificationSelect
        let router = SearchRouter(
            navigationController: navigationController,
            assemblyBuilder: self
        )
        router.setupInitial()
        return router
    }
    
    func createSearchModule(router: SearchRouterProtocol) -> SearchViewController {
        let viewController = SearchViewController()
        let networkManager = NetworkManager.shared
        let realmStoredManager = RealmStorageManager.shared
        let presenter = SearchPresenter(
            view: viewController,
            networkManager: networkManager,
            realmStorageManager: realmStoredManager,
            router: router
        )
        viewController.presenter = presenter
        return viewController
    }
    
    //MARK: - Profile module
    func createProfileRouter() -> ProfileRouterProtocol {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(title: nil, image: .profile, tag: 2)
        navigationController.tabBarItem.selectedImage = .profileSelect
        let router = ProfileRouter(
            navigationController: navigationController,
            assemblyBuilder: self
        )
        router.setupInitial()
        return router
    }
    
    func createProfileModule(router: ProfileRouterProtocol) -> ProfileViewController {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter(view: viewController, router: router)
        viewController.presenter = presenter
        return viewController
    }
    
    //MARK: - RecipeDetail module
    func createRecipeDetailModule(recipe: RecipeProtocol) -> RecipeDetailViewController {
        let viewController = RecipeDetailViewController()
        let presenter = RecipeDetailPresenter(
            view: viewController,
            recipe: recipe
        )
        viewController.presenter = presenter
        return viewController
    }
    
    //MARK: - CreateRecipe module
    func createCreateRouter() -> CreateRouterProtocol {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(title: nil, image: .add, tag: 2)
        navigationController.tabBarItem.selectedImage = .add
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: -20, left: 0, bottom: 30, right: 0)
        let router = CreateRouter(
            navigationController: navigationController,
            assemblyBuilder: self
        )
        router.setupInitial()
        return router
    }
    
    func createCreateModule(router: CreateRouterProtocol) -> CreateViewController {
        let viewController = CreateViewController()
        let presenter = CreateViewPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        return viewController
    }
}

