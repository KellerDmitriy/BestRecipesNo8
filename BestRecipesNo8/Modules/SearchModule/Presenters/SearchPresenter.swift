//
//  SearchPresenter.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 20.09.2023.
//

import Foundation

final class SearchPresenter: SearchPresenterProtocol {
    var view: SearchViewProtocol?
    var route: SearchRouterProtocol?
    var networkManager: NetworkManager?
   
    var savedRecipesId: [Int] = []
    var searchedRecipes: [SearchRecipe] = []
    
    
    init(view: SearchViewProtocol, route: SearchRouterProtocol) {
        self.view = view
        self.route = route
    }
    
    func searchRecipes(with searchText: String) {
        guard !searchText.isEmpty else {
            view?.updateSearchResults(with: [])
            return
        }
        networkManager?.getSearchRecipes(for: searchText) { [weak self] result in
            switch result {
            case .success(let recipes):
                var models: [SearchRecipe] = []
                recipes.results?.forEach { recipe in
                    guard let title = recipe.title, let image = recipe.image else { return }
                    models.append(SearchRecipe(id: recipe.id, title: title, image: image))
                }
                self?.view?.updateSearchResults(with: models)
            case .failure(let error):
                print(error)
                // Handle error as needed
            }
        }
    }
}

