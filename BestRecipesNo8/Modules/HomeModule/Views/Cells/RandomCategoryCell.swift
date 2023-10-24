//
//  RandomCategoryCell.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import UIKit

class RandomCategoryCell: UICollectionViewCell {
    
    static let cellID = String(describing: RandomCategoryCell.self)
    
    // MARK: - Views
    private lazy var recipeImageView: UIImageView = _recipeImageView
    private lazy var titleRecipe: UILabel = _titleRecipe
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method for setup data to elements in every cell
    func updateRecipeData(image: UIImage?, title: String) {
        recipeImageView.image = image
        titleRecipe.text = "\(title)"
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleRecipe)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        
        recipeImageView.snp.makeConstraints { make in
            make.width.height.equalTo(128)
            make.top.centerX.equalToSuperview()
        }
        
        titleRecipe.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(2)
            make.top.equalTo(recipeImageView.snp.bottom).offset(8)
        }
    }
}

// MARK: - Extension for setup elements
private extension RandomCategoryCell {
    
    var _recipeImageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }
    
    var _titleRecipe: UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.poppinsSemiBold(size: 14)
        label.textColor = .black
        return label
    }
}
