//
//  HomeViewProtocol.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 14.09.23.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func openHome()
    func getRecipes()
    func getPopularRecipes()
    func updatePopularCategory()
}
