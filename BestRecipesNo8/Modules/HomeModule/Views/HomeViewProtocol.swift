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
    func getPopularRecipes(with category: String)
    func updatePopularCategory()
    func getDimensions(section: HomeSections) -> (itemWidth: CGFloat, itemHeight: CGFloat, groupWidth: CGFloat, groupHeight: CGFloat)
}
