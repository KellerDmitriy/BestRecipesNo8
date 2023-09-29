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
        
//        let tabbarVC = CustomTabBar()
//        let navigationVC = isShowOnboarding() ? UINavigationController(rootViewController: StartViewController()) : UINavigationController(rootViewController: tabbarVC)
//        navigationVC.setupNavigationBar()
        
        let navigationVC = UINavigationController()
        navigationVC.setupNavigationBar()
        let assemblyBuilder = AssemblyBuilder()
        let tabbar = CustomTabBar()
        let router = Router(assemblyBuilder: assemblyBuilder, tabBarController: tabbar, navigationController: navigationVC)
        router.routeToInitialVC()
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
    
    func isShowOnboarding() -> Bool {
        var showOnboarding = true
        
        if let showOnboardingUDValue = UserDefaults.standard.object(forKey: "showOnboarding") {
            showOnboarding = showOnboardingUDValue as! Bool
        }
        return showOnboarding
    }
}

