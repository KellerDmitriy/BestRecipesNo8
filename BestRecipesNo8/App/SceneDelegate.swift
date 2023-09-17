//
//  SceneDelegate.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 27.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        //todo проверяем, показывали ли уже Onboarding (UserDefaults)
        //Если да, то в rootViewController надо определить CustomTabBar()
        //Если нет, то в rootViewController надо определить StartBuilder.createStartModule()
        let tabbarVC = CustomTabBar()
        let navigationVC = isShowOnboarding() ? UINavigationController(rootViewController: StartViewController()) : UINavigationController(rootViewController: tabbarVC)
        navigationVC.setupNavigationBar()
        window?.rootViewController = navigationVC
    }
    
    func isShowOnboarding() -> Bool {
        var showOnboarding = true
        
        if let showOnboardingUDValue = UserDefaults.standard.object(forKey: "showOnboarding") {
            showOnboarding = showOnboardingUDValue as! Bool
        }
        
        return showOnboarding
    }



}

