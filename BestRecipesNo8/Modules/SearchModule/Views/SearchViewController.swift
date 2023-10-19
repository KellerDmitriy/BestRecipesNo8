//
//  SearchViewController.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 20.09.2023.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    var presenter: SearchPresenterProtocol!
    
    //MARK: Private properties
    private var timer: Timer?
    
    private let searchController = UISearchController(searchResultsController: nil)

    private lazy var searchTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.delegate = self
        table.dataSource = self
        table.register(SearchViewCell.self, forCellReuseIdentifier: SearchViewCell.cellID)
        return table
    }()
                            
    //MARK: - LifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Get amazing recipes for cooking"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchController.isActive = false
        searchTableView.reloadData()
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
        searchController.obscuresBackgroundDuringPresentation = false
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.hidesBarsWhenKeyboardAppears = false
    }
    
}
//MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.searchedRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: SearchViewCell.cellID, for: indexPath) as? SearchViewCell else { return UITableViewCell() }
        let searchRecipe = presenter.searchedRecipes[indexPath.row]
        cell.configure(model: searchRecipe)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = presenter.searchedRecipes[indexPath.row]
        presenter.router.routeToDetailRecipeScreen(recipe: recipe)
    }
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchRecipes(with: "")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchController.isActive = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { [weak self] timer in
            self?.presenter?.searchRecipes(with: searchText)
            
        })
    }
}

//MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isActive else { return }
        
        guard searchController.isActive, let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            return
        }
        presenter?.searchRecipes(with: searchText)
    }
}

//MARK: - Search Recipes
extension SearchViewController: SearchViewProtocol {
    func updateSearchResults(with models: [RecipeProtocol]) {
        presenter.searchedRecipes = models
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
        }
    }
}
