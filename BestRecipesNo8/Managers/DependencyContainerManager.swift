//
//  DependencyContainerManager.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 02.10.2023.
//

import UIKit

//final class DependencyContainerManager {
//    static let shared = DependencyContainerManager()
//    
//    private init() {}
//    
//    let assemblyBuilder = AssemblyBuilder()
//    var router: RouterProtocol?
//    var navigationController: UINavigationController?
//    var customTabBarController: CustomTabBarController?
//    
//    func setup() {
//        router = Router(
//            assemblyBuilder: assemblyBuilder,
//            navigationController: navigationController ?? UINavigationController())
//        customTabBarController = CustomTabBarController(
//            assemblyBuilder: assemblyBuilder,
//            router: router ?? Router(assemblyBuilder: assemblyBuilder,
//                                     navigationController: nil), realmSavedRecipes: <#Results<RecipeRealmModel>#>
//        )
//        navigationController?.viewControllers = [customTabBarController].compactMap { $0 }
//    }
//}
