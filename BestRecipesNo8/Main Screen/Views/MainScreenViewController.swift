//
//  MainScreenViewController.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 27.08.2023.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    var timer: Timer?
    var presenter: MainPresenterProtocol!
    var popularCategoryDelegate: PopularCategoryDelegate!
    
    private var trendingCategoryCell: TrendingCategoryCell?
    private let searchTableView = SearchTableView()
    
    //MARK: - UI Elementes:
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 24)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = "Get amazing recipes \nfor cooking"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = searchController.searchBar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search for recipes"
        searchBar.tintColor = .whiteColor
        searchBar.searchBarStyle = .default
        searchBar.barTintColor = .white
        return searchBar
    }()
    
    private lazy var recipesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TrendingCollectionTableViewCell.self, forCellReuseIdentifier: TrendingCollectionTableViewCell.reuseIdentifier)
        tableView.register(PopularCategoryTableViewCell.self, forCellReuseIdentifier: PopularCategoryTableViewCell.reuseIdentifier)
        tableView.register(RecentRecipeTableViewCell.self, forCellReuseIdentifier: RecentRecipeTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - LifeCyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        getRecipes()
        setupUIForSearch()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //presenter.searchedRecipes = recipesModels
        updateSearchTableView(with: presenter.searchedRecipes)
        searchController.isActive = false
        hideSearchTableView(isTableViewHidden: true)
        recipesTableView.reloadData()
    }
    
    //MARK: - Methods for Header's Button
    @objc private func seeAllButtonTapped() {
        presenter.seeAllButtonTapped()
    }
    
    @objc private func seeAllRecipeSectionButtonTapped() {
        presenter.seeAllButtonTapped()
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(searchTableView)
        view.addSubview(recipesTableView)
        view.addSubview(searchBar)
        
        // Create and configure the UISearchController
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            searchTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            searchTableView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            searchTableView.heightAnchor.constraint(equalToConstant: 44),
            
            recipesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12),
            recipesTableView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            recipesTableView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            recipesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

//MARK: UITableViewDelegate & UITableViewDataSource

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCollectionTableViewCell.reuseIdentifier, for: indexPath) as? TrendingCollectionTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(recipes: presenter.trendingNowRecipes, presenter: popularCategoryDelegate)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularCategoryTableViewCell.reuseIdentifier, for: indexPath) as? PopularCategoryTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(recipes: presenter.popularCategoryRecipes, presenter: popularCategoryDelegate)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentRecipeTableViewCell.reuseIdentifier, for: indexPath) as? RecentRecipeTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(recipes: presenter.recentRecipe)
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let trendingNowSectionView = TrendingNowSectionView()
            trendingNowSectionView.seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
            return trendingNowSectionView
        case 1:
            return PopularCategorySectionView()
        case 2:
            let recentRecipeSectionView = RecentRecipeSectionView()
            recentRecipeSectionView.seeAllButton.addTarget(self, action: #selector(seeAllRecipeSectionButtonTapped), for: .touchUpInside)
            return recentRecipeSectionView
        default:
            return TrendingNowSectionView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 220
        case 1:
            return 355
        case 2:
            return 258
        default:
            return 300
        }
    }
}

// MARK: - Methods for SearchBar
extension MainScreenViewController {
    
    func setupUIForSearch() {
        setDelegate()
        configureNavigationBar()
    }
    
    func setDelegate() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.hidesBarsWhenKeyboardAppears = false
    }
    
    private func updateUI(with recipes: [SearchRecipe]) {
        DispatchQueue.main.async {
            self.searchTableView.configure(models: recipes, navigationController: self.navigationController)
            self.searchTableView.searchTableView.reloadData()
        }
    }
    
}
// MARK: - UISearchBarDelegate

extension MainScreenViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.fetchSearchedRecipe(with: "")
        hideSearchTableView(isTableViewHidden: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        hideSearchTableView(isTableViewHidden: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { [weak self] timer in
            self?.presenter?.fetchSearchedRecipe(with: searchText)
        })
    }
    
}

// MARK: - UISearchResultsUpdating

extension MainScreenViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isActive else { return }
        
        guard searchController.isActive, let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            return
        }
        presenter?.fetchSearchedRecipe(with: searchText)
    }
}

// MARK: - MainScreenViewControllerProtocol
extension MainScreenViewController: MainScreenViewControllerProtocol {
    // MARK: - MainScreenViewControllerProtocol
    
    func updateSearchTableView(with recipes: [SearchRecipe]) {
        updateUI(with: recipes)
    }
    
    func hideSearchTableView(isTableViewHidden: Bool) {
        searchTableView.isHidden = isTableViewHidden
        recipesTableView.isHidden = !isTableViewHidden
    }
    
    func updatePopularCategory() {
        recipesTableView.reloadData()
    }
    
    func getPopularRecipes() {
        DispatchQueue.main.async {
            self.recipesTableView.reloadData()
        }
    }
    
    func getRecipes() {
        presenter.networkManager.getTenPopularRecipes { result in
            switch result {
            case .success(let results):
                let recipes = results
                self.presenter.trendingNowRecipes = recipes
                DispatchQueue.main.async {
                    self.recipesTableView.reloadData()
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        presenter.networkManager.getRandomRecipes { result in
            switch result {
            case .success(let results):
                if let recipes = results.recipes {
                    self.presenter.recentRecipe = recipes
                    DispatchQueue.main.async {
                        self.recipesTableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

