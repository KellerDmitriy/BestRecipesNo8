//
//  SearchBuilder.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 20.09.2023.
//

import Foundation

final class SearchBuilder {
    static func createSearchModule() {
        let router = SearchRouter()
        let view = SearchVC()
        let presenter = SearchPresenter(view: view, route: router)
    }
}
