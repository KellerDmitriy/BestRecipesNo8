//
//  SeeAllViewController.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import UIKit

class SeeAllViewController: UIViewController {
    
    var presenter: SeeAllPresenterProtocol!
    
    // MARK: - Private Properties
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(SeeAllCollectionViewCell.self, forCellWithReuseIdentifier: SeeAllCollectionViewCell.cellID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Life View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        navigationItem.title = "Trending now"
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    // MARK: - UICollectionViewCompositionalLayout
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}

// MARK: UICollectionViewDataSource

extension SeeAllViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter.seeAllRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeeAllCollectionViewCell.cellID, for: indexPath) as? SeeAllCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let recipe = self.presenter.seeAllRecipes[indexPath.row]
        cell.configureCell(recipe: recipe)
        return cell
    }   
}

extension SeeAllViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = presenter.seeAllRecipes[indexPath.row]
        presenter.router?.routeToRecipeDetailScreen(recipe: recipe)
        
    }
}

extension SeeAllViewController: SeeAllViewProtocol {

}
