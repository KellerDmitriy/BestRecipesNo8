//
//  SearchViewProtocol.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 20.09.2023.
//

import Foundation
protocol SearchViewProtocol: AnyObject {
    func updateSearchResults(with models: [SearchRecipe])
}
