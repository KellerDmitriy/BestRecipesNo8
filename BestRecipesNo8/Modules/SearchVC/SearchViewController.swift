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
    private var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private var timer: Timer?
    private let networkManager = NetworkManager.shared
    private var searchedRecipes: [SearchRecipe] = []
    
    let searchTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SearchViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Get amazing recipes for cooking"
        setupUI()
    //    navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? SearchViewCell else { return UITableViewCell() }
        cell.configure(
            model: searchedRecipes[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: Setup

extension SearchViewController {
    
    func setupUI() {
        view.addSubview(searchTableView)
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


    // MARK: - Private methods
    
    func configure(models: [SearchRecipe]) {
        searchedRecipes = models
    }
    
    func updateSearchTableView() {
        DispatchQueue.main.async {
            self.configure(models: self.searchedRecipes)
            self.searchTableView.reloadData()
        }
    }
}



//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        updateSearchTableView()

    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
 
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
        let group = DispatchGroup()
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] timer in
            group.enter()
            self?.networkManager.getSearchRecipes(for: searchText) { result in
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
                    self?.searchedRecipes = models
                    print(models)
          
                    self?.updateSearchTableView()
                case .failure(let error):
                    print(error)
                }
            }
        })
        
        group.notify(queue: .main) {
            // All requests have completed
        }
    }
}
