//
//  SearchPresenter.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 20.09.2023.
//

import Foundation

final class SearchPresenter: SearchPresenterProtocol, SearchModuleProtocol {
    
    
    weak var view: SearchViewProtocol?
    var router: SearchRouterProtocol
    
    var networkManager = NetworkManager.shared
    var realmStorageManager = RealmStorageManager.shared
    
    var savedRecipesId: [Int] = []
    var searchedRecipes: [RecipeProtocol] = []
    
    required init(view: SearchViewProtocol, networkManager: NetworkManager, realmStorageManager: RealmStorageManager, router: SearchRouterProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.realmStorageManager = realmStorageManager
        self.router = router
    }
    
    func searchRecipes(with searchText: String) {
        guard !searchText.isEmpty else {
            view?.updateSearchResults(with: [])
            return
        }
        
        DispatchQueue.global().async {
            self.networkManager.getSearchRecipes(for: searchText) { [unowned self] result in
                switch result {
                case .success(let recipes):
                    var models: [RecipeProtocol] = []
                    let dispatchGroup = DispatchGroup()
                    
                    recipes.results?.forEach { recipe in
                        dispatchGroup.enter()
                        self.networkManager.getRecipeInformation(for: recipe.id) { detailedResult in
                            defer {
                                dispatchGroup.leave()
                            }
                            switch detailedResult {
                            case .success(let data):
                                guard
                                    let title = data.title,
                                    let image = data.image
                                else { return }
                                
                                let searchRecipe = SearchRecipe(
                                    id: data.id,
                                    title: title,
                                    image: image
                                )
                                models.append(searchRecipe)
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
                    dispatchGroup.notify(queue: .main) {
                        self.view?.updateSearchResults(with: models)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func updateSearchResults(with recipes: [RecipeProtocol]) {
        view?.updateSearchResults(with: recipes)
    }
}
#warning("проверить метод для доп свойств по ингридиентам")
//func updateRecipe() {
//    if let savedRecipesId = UserDefaults.standard.object(forKey: "savedRecipes") as? [Int] {
//        NetworkManager.shared.getRecipeInformationBulk(for: savedRecipesId) { result in
//            switch result {
//            case .success(let recipes):
//              //  self.savedRecipes = recipes
//                self.view?.openSavedRecipes()
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
