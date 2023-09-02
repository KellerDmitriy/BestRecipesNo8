//
//  PopularCategoryTableViewCell.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 29.08.2023.
//

import UIKit

final class PopularCategoryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var popularCategoryRecipes: [RecipeInfo] = popularCategoryRecipesMock
    
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
            cell.configureCell(header: Constants.mealTypes[indexPath.row])
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
}

let RecipeInfoMockBorsch = RecipeInfo(id: 0, title: "Borsch", summary: nil, image: "https://otkritkis.com/wp-content/uploads/2021/12/kak-svarit-borshh-640x342-1.jpg", sourceUrl: nil, preparationMinutes: nil, cookingMinutes: nil, readyInMinutes: 25, servings: nil, aggregateLikes: nil, spoonacularScore: nil, creditsText: nil, sourceName: nil, dichTypes: nil, diets: nil, extendedIngredients: nil, analyzedInstructions: nil)

let RecipeInfoMockKasha = RecipeInfo(id: 0, title: "Kasha", summary: nil, image: "https://eda.ru/img/eda/c620x415/s1.eda.ru/StaticContent/Photos/160302171541/160308173944/p_O.jpg", sourceUrl: nil, preparationMinutes: nil, cookingMinutes: nil, readyInMinutes: 2, servings: nil, aggregateLikes: nil, spoonacularScore: nil, creditsText: nil, sourceName: nil, dichTypes: nil, diets: nil, extendedIngredients: nil, analyzedInstructions: nil)

let RecipeInfoMockSshaskyk = RecipeInfo(id: 0, title: "Shashlyk", summary: nil, image: "https://img1.russianfood.com/dycontent/images_upl/37/big_36405.jpg", sourceUrl: nil, preparationMinutes: nil, cookingMinutes: nil, readyInMinutes: 15, servings: nil, aggregateLikes: nil, spoonacularScore: nil, creditsText: nil, sourceName: nil, dichTypes: nil, diets: nil, extendedIngredients: nil, analyzedInstructions: nil)


let popularCategoryRecipesMock = [RecipeInfoMockBorsch, RecipeInfoMockKasha, RecipeInfoMockSshaskyk]
