//
//  SeeAllPresenterProtocol.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import Foundation

protocol SeeAllPresenterProtocol: AnyObject {
    var trendingNowRecipes: [RecipeInfo] { get }
    var router: SeeAllRouterProtocol { get }

    func cellTapped()
    func saveButtonTapped()
}
