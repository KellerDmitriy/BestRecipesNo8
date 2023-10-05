//
//  MainViewController.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 27.08.2023.
//

import UIKit

final class MainViewController: UIViewController {

    var presenter: MainPresenterProtocol!
    var popularCategoryDelegate: PopularCategoryDelegate!
    
    private var timer: Timer?
    private var trendingCategoryCell: TrendingCategoryCell?
    private var searchVC: UIViewController?
    
    //MARK: - UI Elementes:
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: searchVC)
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
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
        searchVC = presenter.searchController.createSearchModule(router: presenter.router)
        view.backgroundColor = .white
        navigationItem.title = "Get amazing recipes cooking"
        let navigationBarAppearance = navigationController?.navigationBar.standardAppearance
        var titleAttributes = navigationBarAppearance?.largeTitleTextAttributes
        titleAttributes?[.font] = UIFont(name: "Poppins-Bold", size: 38)
        titleAttributes?[.font] = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipesTableView.reloadData()
        searchController.isActive = false
    }
    
    //MARK: - Methods for Header's Button
    @objc private func seeAllButtonTapped() {
        presenter.seeAllButtonTapped()
    }
    
    @objc private func seeAllRandomSectionButtonTapped() {
        presenter.seeAllRandomSectionButtonTapped()
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        view.backgroundColor = .whiteColor
        navigationItem.searchController = searchController
        view.addSubview(searchController.searchBar)
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
// MARK: - UISearch
extension MainViewController {
    func setDelegate() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    private func setupNavigationBar() {
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .white
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.neutralColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.neutralColor]
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.hidesBarsWhenKeyboardAppears = false
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.fetchSearchedRecipe(with: "")
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchController.isActive = true
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

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isActive else { return }
        
        guard searchController.isActive, let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            return
        }
        searchController.showsSearchResultsController = (searchVC != nil)
        presenter?.fetchSearchedRecipe(with: searchText)
        print(searchText)
    }
}

// MARK: - MainScreenViewControllerProtocol
extension MainViewController: MainScreenViewControllerProtocol {
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.hidesBarsWhenKeyboardAppears = false
    }
    
    func configureSearchResults(models: [RecipeProtocol]) {
        presenter.searchedRecipes = models
        DispatchQueue.main.async {
            self.recipesTableView.reloadData()
        }
    }
    
    func hideMainTableView(isTableViewHidden: Bool) {
        //
    }
    

    
    
   
    // MARK: - MainScreenViewControllerProtocol
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

