//
//  MainViewController.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 27.08.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol!

    var searchPresenter: SearchPresenterProtocol!
    
    var popularCategoryDelegate: PopularCategoryDelegate!
    
    private var timer: Timer?
    private var trendingCategoryCell: TrendingCategoryCell?
    
    
    //MARK: - UI Elementes:
    var searchController: UISearchController!
    
    private lazy var recipesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TrendingCollectionTableViewCell.self, forCellReuseIdentifier: TrendingCollectionTableViewCell.reuseIdentifier)
        tableView.register(PopularCategoryTableViewCell.self, forCellReuseIdentifier: PopularCategoryTableViewCell.reuseIdentifier)
        tableView.register(RandomRecipeTableViewCell.self, forCellReuseIdentifier: RandomRecipeTableViewCell.reuseIdentifier)
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
        updateSearchUI()
        view.backgroundColor = .white
        navigationItem.title = "Get amazing recipes cooking"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipesTableView.reloadData()
    }
    
    //MARK: - Methods for Header's Button
    @objc private func seeAllButtonTapped() {
        presenter.seeAllButtonTapped(with: .trendingNow)
    }
    
    @objc private func seeAllRandomSectionButtonTapped() {
        presenter.seeAllButtonTapped(with: .random)
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        view.backgroundColor = .whiteColor
        view.addSubview(recipesTableView)
    }
    
    
    private func setupLayout() {
        
        recipesTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

//MARK: Search Methods
extension MainViewController {
    func updateSearchUI() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Recipes"
        
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            presenter.performSearch(with: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            presenter.performSearch(with: searchText)
        }
    }
}

//MARK: UITableViewDelegate & UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RandomRecipeTableViewCell.reuseIdentifier, for: indexPath) as? RandomRecipeTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(recipes: presenter.randomRecipe)
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
            let randomRecipeSectionView = RandomRecipeSectionView()
            randomRecipeSectionView.seeAllButton.addTarget(self, action: #selector(seeAllRandomSectionButtonTapped), for: .touchUpInside)
            return randomRecipeSectionView
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

// MARK: - MainScreenViewControllerProtocol
extension MainViewController: MainScreenViewControllerProtocol {
    func updatePopularCategory() {
        recipesTableView.reloadData()
    }
    
    func getPopularRecipes() {
        DispatchQueue.main.async {
            self.recipesTableView.reloadData()
        }
    }
    
    func getRecipes() {
        presenter.networkManager.getTenPopularRecipes(sortedBy: .trendingNow) { result in
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
                if let recipes = results.results {
                    self.presenter.randomRecipe = recipes
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

