//
//  SceneDelegate.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 27.08.2023.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
      
        let assemblyBuilder = AssemblyBuilder()
        let tabBar: CustomTabBarController = assemblyBuilder.createTabBar()
        
        let mainRouter: MainRouterProtocol = assemblyBuilder.createMainRouter()
        let savedRecipesRouter: SavedRecipesRouterProtocol = assemblyBuilder.createSavedRecipesRouter()
        let createRecipeRouter: CreateRouterProtocol = assemblyBuilder.createCreateRouter()
        let searchRouter: SearchRouterProtocol = assemblyBuilder.createSearchRouter()
        let profileRouter: ProfileRouterProtocol = assemblyBuilder.createProfileRouter()
        
        tabBar.navigationControllers(
            mainRouter.navigationController,
            savedRecipesRouter.navigationController,
            createRecipeRouter.navigationController,
            searchRouter.navigationController,
            profileRouter.navigationController)
        
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
       
    }
}

