//
//  SavedRecipesView.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import UIKit
import SnapKit

final class SavedRecipesView: UIViewController {
    
    private let presenter: SavedRecipesPresenter
    private var recipes: [RecipeInfo] = []
    
    // MARK: - Views
    private lazy var scrollView: UIScrollView = _scrollView
    private lazy var contentView: UIView = _contentView
    
    private lazy var savedRecipesTitle: UILabel = _savedRecipesTitle
    private lazy var collectionView: UICollectionView = _collectionView
    
    private let heightOfCollectionView: Int
    private let minimumSpaceBetweenCells: CGFloat = 100
    
    // MARK: - Init
    init(presenter: SavedRecipesPresenter) {
        self.presenter = presenter
      
        heightOfCollectionView = (200 + Int(minimumSpaceBetweenCells)) * recipes.count
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        applyConstraints()
      
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        contentView.addSubview(savedRecipesTitle)
        contentView.addSubview(collectionView)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        savedRecipesTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(22)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(savedRecipesTitle.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(0)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(0)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(heightOfCollectionView)
        }
    }
    
    // MARK: - UICollectionViewCompositionalLayout
    
    private var customCollectionViewLayout: UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width - 40, height: 200)
        layout.minimumLineSpacing = minimumSpaceBetweenCells
        return layout
    }
}

// MARK: UICollectionViewDataSource

extension SavedRecipesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedRecipeCell.cellID, for: indexPath) as! SavedRecipeCell
        
        let recipe = recipes[indexPath.row]
        cell.updateRecipeData(
            image: recipe.image,
            rating: recipe.aggregateLikes,
            title: recipe.title,
            time: recipe.preparationMinutes
        )
        
        return cell
    }
}

extension SavedRecipesView: SavedRecipesViewInput {
    func openSavedRecipes() {
        print("Saved recipes are opened")
    }
    
    func removeRecipe(at index: Int) {
        presenter.removeRecipe(at: index)
           // Update the UI to reflect the updated savedRecipes array
       }
}

// MARK: - Extension for setup elements
private extension SavedRecipesView {
    
    var _scrollView: UIScrollView {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }
    
    var _contentView: UIView {
        let view = UIView()
        return view
    }
    
    var _savedRecipesTitle: UILabel {
        let label = UILabel()
        label.text = "Saved recipes"
        label.font = UIFont.poppinsSemiBold(size: 24)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }
    
    var _collectionView: UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: customCollectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.register(SavedRecipeCell.self, forCellWithReuseIdentifier: SavedRecipeCell.cellID)
        collectionView.isScrollEnabled = false
        return collectionView
    }
}
