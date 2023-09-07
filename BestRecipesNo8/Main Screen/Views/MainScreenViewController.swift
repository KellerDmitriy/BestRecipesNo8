//
//  MainScreenViewController.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 27.08.2023.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    var presenter: MainPresenterProtocol!
    var popularCategoryDelegate: PopularCategoryHeaderCellDelegate!
    
    //MARK: - UI Elementes:
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 24)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = "Get amazing recipes \nfor cooking"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        presenter.getNewRecipes()
        getRecipes()
    }
    
    //MARK: - Methods for Header's Button
    @objc private func seeAllButtonTapped() {
        // print("seeAllButtonTap")
        presenter.seeAllButtonTapped()
    }
    
    @objc private func seeAllRecipeSectionButtonTapped() {
        // print("seeAllRecipeSectionButtonTapped")
        presenter.seeAllButtonTapped()
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(recipeSearchField)
        view.addSubview(recipesTableView)
    }
    
    
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            recipeSearchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            recipeSearchField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            recipeSearchField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            recipeSearchField.heightAnchor.constraint(equalToConstant: 44),
            
            recipesTableView.topAnchor.constraint(equalTo: recipeSearchField.bottomAnchor, constant: 12),
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
            cell.configureCell(recipes: presenter.trendingNowRecipes)
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

extension MainScreenViewController: MainScreenViewControllerProtocol {
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

