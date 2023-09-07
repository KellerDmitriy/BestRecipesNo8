//
//  SearchTableViewController.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 07.09.2023.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    //MARK: Private properties
    private var timer: Timer?
    private let networkManager = NetworkManager.shared
    private var filteredRecipes: [SearchRecipe] = []
    private var searchedRecipes: SearchResult?
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return !searchBarIsEmpty && searchController.isActive
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        tableView.register(SearchViewCell.self, forCellReuseIdentifier: SearchViewCell.cellID)
    }
    
    // MARK: - Private methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = .clear
        searchController.searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchController.searchBar.layer.borderWidth = 1.0
        searchController.searchBar.layer.cornerRadius = 10.0
        searchController.searchBar.placeholder = "Search recipes"
        searchController.searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.poppinsSemiBold(size: 16)
            textField.textColor = .neutralColor50
        }
    }
    
    private func fetchData(with searchText: String?) {
        networkManager.getSearchRecipes(for: searchText) { result in
            switch result {
            case .success(let recipe):
                self.searchedRecipes = recipe
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print("ok")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredRecipes.count : searchedRecipes?.results?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchViewCell.cellID,
            for: indexPath
        )
        guard let cell = cell as? SearchViewCell else { return UITableViewCell() }
        let recipe = isFiltering
        ? filteredRecipes[indexPath.row]
        : searchedRecipes?.results?[indexPath.row]
        cell.configureCell(recipe: recipe!)
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        fetchData(with: searchText)
        filterContentForSearchText(searchText ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredRecipes = searchedRecipes?.results?.filter { recipe in
            if let title = recipe.title {
                return title.lowercased().contains(searchText.lowercased())
            } else {
                return false
            }
        } ?? []
        
        tableView.reloadData()
    }
}
