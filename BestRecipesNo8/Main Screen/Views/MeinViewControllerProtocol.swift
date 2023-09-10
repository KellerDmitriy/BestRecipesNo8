//
//  MeinViewControllerProtocol.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 31.08.2023.
//

import Foundation

protocol MainScreenViewControllerProtocol: AnyObject {
    func getRecipes()
    func getPopularRecipes()
    func updatePopularCategory()
    func updateSearchTableView(with recipes: [SearchRecipe])
    func hideSearchTableView(isTableViewHidden: Bool)
    
}


