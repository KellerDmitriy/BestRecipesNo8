//
//  SearchPresenter.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 20.09.2023.
//

import Foundation

final class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewProtocol?
    var router: RouterProtocol?
    
    var networkManager = NetworkManager.shared
    var realmStorageManager = RealmStorageManager.shared
   
    var savedRecipesId: [Int] = []
    var searchedRecipes: [RecipeProtocol] = []

    required init(view: SearchViewProtocol, networkManager: NetworkManager, realmStorageManager: RealmStorageManager, router: RouterProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.realmStorageManager = realmStorageManager
        self.router = router
    }
    
    func searchRecipes(with searchText: String) {
        let group = DispatchGroup()
        group.enter()
        networkManager.getSearchRecipes(for: searchText) { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let recipes):
                var models: [SearchRecipe] = []
                recipes.results?.forEach({ recipe in
                    guard let title = recipe.title, let image = recipe.image else { return }
                    models.append(SearchRecipe(id: recipe.id, title: title, image: image))
                })
                self?.view?.updateSearchResults(with: models)
                
            case .failure(let error):
                print(error)
            }
        }
        
        group.notify(queue: .main) {
        }
    }
}
//    func fetchSearchedRecipe(with searchText: String) {
//        networkManager.getSearchRecipes(for: searchText) { [weak self] result in
//            switch result {
//            case .success(let recipes):
//                var models: [SearchRecipe] = []
//                recipes.results?.forEach { recipe in
//                    guard let title = recipe.title, let image = recipe.image else { return }
//                    models.append(SearchRecipe(id: recipe.id, title: title, image: image))
//                }
//                self?.view?.configureSearchResults(models: models)
//                
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }


