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
    private var filteredRecipes: [RecipeInfo] = []
    private var searchedRecipes: RandomRecipe?
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return !searchBarIsEmpty && searchController.isActive
    }
    
    private lazy var recipeSearchField: UISearchTextField = {
        let searchField = UISearchTextField()
        searchField.backgroundColor = .whiteColor
        searchField.textColor = .black
        searchField.layer.borderColor = UIColor.lightGray.cgColor
        searchField.layer.borderWidth = 1.0
        searchField.layer.cornerRadius = 10.0
        searchField.attributedPlaceholder = NSAttributedString(string: "Search recipes", attributes: [.foregroundColor: UIColor.lightGray])
        
        searchField.translatesAutoresizingMaskIntoConstraints = false
        return searchField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
    }
    
    // MARK: - Private methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
}
// MARK: - UITableViewDataSource
extension SearchTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredRecipes.count : searchedRecipes?.recipes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        guard let cell = cell as? SearchViewCell else { return UITableViewCell() }
        let recipe = isFiltering
            ? filteredRecipes[indexPath.row]
        : searchedRecipes?.recipes?[indexPath.row]
        cell.configureCell(recipe: recipe!)
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredRecipes = searchedRecipes?.recipes?.filter { recipe in
            if let title = recipe.title {
                return title.lowercased().contains(searchText.lowercased())
            } else {
                return false
            }
        } ?? []
        
        tableView.reloadData()
    }
}
