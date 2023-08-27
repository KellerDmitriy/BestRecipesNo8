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
        label.font = UIFont.boldSystemFont(ofSize: 24)
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
    
    private lazy var recipesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        view.addSubview(recipesCollectionView)
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
            
            recipesCollectionView.topAnchor.constraint(equalTo: recipeSearchField.bottomAnchor, constant: 12),
            recipesCollectionView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            recipesCollectionView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            recipesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
