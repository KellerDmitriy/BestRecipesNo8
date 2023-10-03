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
        
        let navigationVC = UINavigationController()
        navigationVC.setupNavigationBar()
        let assemblyBuilder = AssemblyBuilder()
        let router = Router(assemblyBuilder: assemblyBuilder, navigationController: navigationVC)
        let tabBarController = CustomTabBarController(assemblyBuilder: assemblyBuilder, router: router)
        if isShowOnboarding() {
            navigationVC.setViewControllers([StartViewController()], animated: false)
        } else {
            navigationVC.setViewControllers([tabBarController], animated: false)
        }
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

