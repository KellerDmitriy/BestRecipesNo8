//
//  MainViewControllerProtocol.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 31.08.2023.
//

import Foundation

protocol MainScreenViewControllerProtocol: AnyObject {
    func getRecipes()
    func getPopularRecipes()
    func updatePopularCategory()

    func configureNavigationBar() 
    func configureSearchResults(models: [RecipeProtocol])
    func hideMainTableView(isTableViewHidden: Bool)
    
}


