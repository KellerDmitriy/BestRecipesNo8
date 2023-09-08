//
//  SearchViewController.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 07.09.2023.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    //MARK: Private properties
    private let searchTableView = SearchTableView()
    private var timer: Timer?
    private let networkManager = NetworkManager.shared
    private var recipesModels: SearchResult?
    private var searchedRecipes: [SearchRecipe] = []
  
    
    private var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Get amazing recipes for cooking"
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        updateSearchTableView()
        searchController.isActive = false
        hideSearchTableView(isTableViewHidden: true)
    }
    
    // MARK: - Private methods
    
    func updateSearchTableView() {
        searchTableView.configure(models: searchedRecipes, navigationController: navigationController)
        searchTableView.searchTableView.reloadData()
    }
    
    func hideSearchTableView(isTableViewHidden: Bool) {
        searchTableView.isHidden = isTableViewHidden
    }
}
//MARK: - Setup

private extension SearchViewController {
    
    func setup() {
        setDelegate()
        setupView()
        setConstraints()
        configureNavigationBar()
    }
    
    func setDelegate() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    func setupView() {
        navigationItem.searchController = searchController
        view.addSubview(searchTableView)
    }
    
    func setConstraints() {
        searchTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.hidesBarsWhenKeyboardAppears = false
    }
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      
        updateSearchTableView()
        hideSearchTableView(isTableViewHidden: true)
    }
 
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        hideSearchTableView(isTableViewHidden: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty else { return }
        
        searchController.isActive = false
        searchedRecipes = []
        updateSearchTableView()
    }
}

//MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isActive else { return }
        
        guard searchController.isActive, let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            return
        }
        fetchSearchedRecipe(with: searchText)
    }
}

//MARK: - Search Recipes
private extension SearchViewController {
    private func fetchSearchedRecipe(with searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] timer in
            self?.networkManager.searchRecipe(keyWord: searchText) { [weak self] result in
                switch result {
                case .success(let recipes):
                    let dispatchGroup = DispatchGroup()
                    var models: [SearchRecipe] = []
                    recipes.forEach { recipe in
                        dispatchGroup.enter()
                        self?.networkManager.getRecipeInformation(for: recipe.id) { result in
                            defer { dispatchGroup.leave() }
                            switch result {
                            case .success(let data):
                                guard let title = data.title, let image = data.image else { return }
                                models.append(SearchRecipe(id: data.id ?? 0, title: title, image: image))
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }

                    dispatchGroup.notify(queue: .main) {
                        self?.searchedRecipes = models
                        self?.updateSearchTableView()
                        self?.hideSearchTableView(isTableViewHidden: false)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}
