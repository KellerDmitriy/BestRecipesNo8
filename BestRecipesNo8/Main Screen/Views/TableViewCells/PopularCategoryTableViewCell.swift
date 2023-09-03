//
//  PopularCategoryTableViewCell.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 29.08.2023.
//

import UIKit

final class PopularCategoryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var popularCategoryRecipes: [SearchRecipe] = []
    private var presenter: PopularCategoryHeaderCellDelegate?
    
    // MARK: - UI Elements
    
    private lazy var headerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
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
        setupCollectionsView()
        selectFirstCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods:
    
    private func setupCollectionsView() {
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        recipesCollectionView.register(PopularCategoryCell.self, forCellWithReuseIdentifier: PopularCategoryCell.reuseIdentifier)
        headerCollectionView.register(PopularCategoryHeaderCell.self, forCellWithReuseIdentifier: PopularCategoryHeaderCell.reuseIdentifier)
    }
    
    private func selectFirstCell() {
        let indexPath = IndexPath(item: 0, section: 0)
        headerCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
    }
    
    func configureCell(recipes: [SearchRecipe], presenter: PopularCategoryHeaderCellDelegate) {
        self.popularCategoryRecipes = recipes
        self.presenter = presenter
        recipesCollectionView.reloadData()
    }
    
    private func setupUI() {
        contentView.addSubview(recipesCollectionView)
        contentView.addSubview(headerCollectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            headerCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            headerCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerCollectionView.heightAnchor.constraint(equalToConstant: 34),
            
            recipesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19),
            recipesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            recipesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

extension PopularCategoryTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case headerCollectionView:
            return Constants.mealTypes.count
        case recipesCollectionView:
            return popularCategoryRecipes.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case headerCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCategoryHeaderCell.reuseIdentifier, for: indexPath) as? PopularCategoryHeaderCell else { return UICollectionViewCell()}
            guard let presenter = presenter else { return cell}
            cell.configureCell(header: Constants.mealTypes[indexPath.row], delegate: presenter)
            cell.isSelected ? cell.selectCell() : cell.deselectCell()
            return cell
        case recipesCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCategoryCell.reuseIdentifier, for: indexPath) as? PopularCategoryCell else { return UICollectionViewCell() }
            cell.configureCell(at: popularCategoryRecipes[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case headerCollectionView:
            let cellWidth: CGFloat = 83
            let cellHeight: CGFloat = 34
            return CGSize(width: cellWidth, height: cellHeight)
        case recipesCollectionView:
            let cellWidth: CGFloat = 150
            let cellHeight: CGFloat = 231
            return CGSize(width: cellWidth, height: cellHeight)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == headerCollectionView else { return }
        if let cell = collectionView.cellForItem(at: indexPath) as? PopularCategoryHeaderCell {
            cell.selectCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard collectionView == headerCollectionView else { return }
        if let cell = collectionView.cellForItem(at: indexPath) as? PopularCategoryHeaderCell {
            cell.deselectCell()
        }
    }
}
