//
//  MainScreenViewController.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 27.08.2023.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    //MARK: - UI Elementes:
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        //label.font = UIFont.boldSystemFont(ofSize: 24)
        label.font = UIFont(name: "Poppins-Bold", size: 24)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = "Get amazing recipes \nfor cooking"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var recipeSearchField: UISearchTextField = {
        let searchField = UISearchTextField()
        searchField.placeholder = "Search recipes"
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
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCollectionTableViewCell.reuseIdentifier, for: indexPath) as?  TrendingCollectionTableViewCell else { return UITableViewCell() }
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularCategoryTableViewCell.reuseIdentifier, for: indexPath) as?  PopularCategoryTableViewCell else { return UITableViewCell() }
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return TrendingNowSectionView()
        case 1:
            return PopularCategorySectionView()
        case 2:
            return TrendingNowSectionView()
        default:
            return TrendingNowSectionView()
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        3
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            return 300
        case 2:
            return 300
        default:
            return 300
        }
    }
    
    
}
