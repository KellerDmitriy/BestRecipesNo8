//
//  TrendingCollectionTableViewCell.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 29.08.2023.
//

import UIKit

final class TrendingCollectionTableViewCell: UITableViewCell {
    
    // MARK: Properties:
    
    private var trendingNowRecipes: [RecipeInfo] = []
    
    // MARK: - UI Elements
    private lazy var recipesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - LifeCycle:
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
        setupRecipesCollectionView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods:
    
    private func setupRecipesCollectionView() {
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        recipesCollectionView.register(TrendingCategoryCell.self, forCellWithReuseIdentifier: TrendingCategoryCell.reuseIdentifier)
        recipesCollectionView.register(PopularCategoryCell.self, forCellWithReuseIdentifier: PopularCategoryCell.reuseIdentifier)
    }
    
    private func setupUI() {
        contentView.addSubview(recipesCollectionView)
    }
    
    func configureCell(recipes: [RecipeInfo]) {
        self.trendingNowRecipes = recipes
        recipesCollectionView.reloadData()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            recipesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            recipesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            recipesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

extension TrendingCollectionTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingNowRecipes.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCategoryCell.reuseIdentifier, for: indexPath) as? TrendingCategoryCell else { return UICollectionViewCell() }

        cell.configureCell(at: trendingNowRecipes[indexPath.row])
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 280
        let cellHeight: CGFloat = 210
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
