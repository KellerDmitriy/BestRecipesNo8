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
    
    
    //MARK: - UI Elementes:
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var recipesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TrendingCollectionTableViewCell.self, forCellReuseIdentifier: TrendingCollectionTableViewCell.reuseIdentifier)
        tableView.register(PopularCategoryTableViewCell.self, forCellReuseIdentifier: PopularCategoryTableViewCell.reuseIdentifier)
        tableView.register(RandomRecipeTableViewCell.self, forCellReuseIdentifier: RandomRecipeTableViewCell.reuseIdentifier)
        tableView.register(SearchViewCell.self, forCellReuseIdentifier: SearchViewCell.cellID)
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
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Get amazing recipes cooking"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
      //  searchController.isActive = false
        recipesTableView.reloadData()
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
        
        view.backgroundColor = .systemBackground
        view.addSubview(searchController.searchBar)
        view.addSubview(recipesTableView)
        
        if let navigationBarAppearance = navigationController?.navigationBar.standardAppearance {
            var titleAttributes = navigationBarAppearance.largeTitleTextAttributes
            titleAttributes[.font] = UIFont(name: "Poppins-Bold", size: 24)
            titleAttributes[.font] = UIColor.black
            navigationController?.setupNavigationBar()
        }
    }
    
    private func setupLayout() {
        
        recipesTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        searchController.searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.height.equalTo(40)
        }
    }
}

//MARK: UITableViewDelegate & UITableViewDataSource

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return presenter.searchedRecipes.count
        }  else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchController.isActive {
            return 1
        }  else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchController.isActive {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.cellID, for: indexPath) as? SearchViewCell else {
                return UITableViewCell()
            }
            let searchRecipe = presenter.searchedRecipes[indexPath.row]
            cell.configure(model: searchRecipe)
            cell.selectionStyle = .none
            return cell
        } else {
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
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !searchController.isActive {
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
        return nil
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
        setupNavigationBar()
        setupSearchController()
    }
    
    func setDelegate() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search recipes"
        searchController.searchBar.barTintColor = .black
        navigationItem.searchController = searchController
        
        if let searchField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let paddingView = searchField.leftView as? UIView {
                
                searchField.layer.borderWidth = 1.5
                searchField.layer.cornerRadius = 8
                
                searchField.layer.borderColor = UIColor.gray.cgColor
                searchField.backgroundColor = UIColor.white
                
                paddingView.frame = CGRect(x: 0, y: 0, width: 32, height: searchField.frame.height)
                searchField.leftViewMode = .always
            }
        } else {
            print("searchField is nil")
            
        }
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

extension MainScreenViewController: UISearchBarDelegate {
    
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
    func configureSearchResults(models: [SearchRecipe]) {
        presenter.searchedRecipes = models
        DispatchQueue.main.async {
            self.recipesTableView.reloadData()
        }
        
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

