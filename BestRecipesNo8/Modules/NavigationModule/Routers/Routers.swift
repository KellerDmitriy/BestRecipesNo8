//
//  Routers.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 18.10.2023.
//

import UIKit

final class MainRouter: HomeRouterProtocol{

    //MARK: - Properties
    let navigationController: UINavigationController
    private let assemblyBuilder: HomeScreenAssembly
    
    //MARK: - init(_:)
    init(navigationController: UINavigationController, assemblyBuilder: HomeScreenAssembly) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        navigationController.setupNavigationBar()
    }
    
    //MARK: - Public methods
    func setupInitial() {
        let viewController = assemblyBuilder.createHomeModule(router: self)
        navigationController.viewControllers = [viewController]
    }
    
    func routeToSearchScreen(router: SearchRouterProtocol) {
        let searchViewController = assemblyBuilder.createSearchModule(router: router)
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
    func routeToDetailScreen(recipe: RecipeProtocol) {
        let recipeDetailViewController = assemblyBuilder.createDetailModule(
            recipe: recipe
        )
        navigationController.pushViewController(recipeDetailViewController, animated: true)
    }
    
    func routeToSeeAllScreen(recipes: [RecipeProtocol], sortOrder: Endpoint.SortOrder) {
        let seeAllViewController = assemblyBuilder.createSeeAllModule(
            recipes: recipes,
            router: self,
            sortOrder: sortOrder
        )
        navigationController.pushViewController(seeAllViewController, animated: true)
    }
}

final class SearchRouter: SearchRouterProtocol {
    //MARK: - Properties
    let navigationController: UINavigationController
    private let assemblyBuilder: SearchAssembly
    
    init(navigationController: UINavigationController, assemblyBuilder: SearchAssembly) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        navigationController.setupNavigationBar()
    }
    
    //MARK: - Public methods
    func setupInitial() {
        let viewController = assemblyBuilder.createSearchModule(router: self)
        navigationController.viewControllers = [viewController]
    }
    
    func routeToDetailScreen(recipe: RecipeProtocol) {
        let recipeDetailViewController = assemblyBuilder.createDetailModule(
            recipe: recipe
        )
        navigationController.pushViewController(recipeDetailViewController, animated: true)
    }
}

final class SavedRecipeRouter: SavedRecipesRouterProtocol {
    
    // MARK: Properties
    let navigationController: UINavigationController
    private let assemblyBuilder: SavedRecipesAssembly
    
    // MARK: - init(_:)
    init(
        navigationController: UINavigationController,
        assemblyBuilder: AssemblyBuilder
    ) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        navigationController.setupNavigationBar()
    }
    
    // MARK: Public Methods
    func setupInitial() {
        let viewController = assemblyBuilder.createSavedRecipesModule(router: self)
        navigationController.viewControllers = [viewController]
    }
    
    func routeToDetailScreen(recipe: RecipeProtocol) {
        let detailViewController = assemblyBuilder.createDetailModule(recipe: recipe)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

final class ProfileRouter: ProfileRouterProtocol {
    //MARK: - Properties
    let navigationController: UINavigationController
    private let assemblyBuilder: ProfileAssembly
    
    //MARK: - init(_:)
    init(navigationController: UINavigationController, assemblyBuilder: ProfileAssembly) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        navigationController.setupNavigationBar()
    }
    
    func setupInitial() {
        let viewController = assemblyBuilder.createProfileModule(router: self)
        navigationController.viewControllers = [viewController]
    }
    
    //MARK: - Public methods
    func routeToDetailYourRecipe(recipe: RecipeRealmModel) {
        //
    }
}

final class CreateRouter: CreateRouterProtocol {
    
    let navigationController: UINavigationController
    
    private let assemblyBuilder: CreateAssembly
    
    init(navigationController: UINavigationController, assemblyBuilder: CreateAssembly) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        navigationController.setupNavigationBar()
    }
    
    func setupInitial() {
        let viewController = assemblyBuilder.createCreateModule(router: self)
        navigationController.viewControllers = [viewController]
    }
}
