//
//  RecentCell.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import UIKit

class RecentCategoryPreviewCell: UICollectionViewCell {
    
    static let cellID = String(describing: RecentCategoryPreviewCell.self)
    
    // MARK: - Views
    private lazy var recipeImageView: UIImageView = _recipeImageView
    
    private lazy var ratingView: UIView = _ratingView
    private lazy var ratingLabel: UILabel = _ratingLabel
    private lazy var ratingImageView: UIImageView = _ratingImageView
    
    private lazy var titleRecipe: UILabel = _titleRecipe
    private lazy var infoRecipe: UILabel = _infoRecipe
    
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
    func updateRecipeData(image: UIImage?, rating: Double, title: String, count: Int, minutes: Int) {
        recipeImageView.image = image
        ratingLabel.text = String(rating)
        titleRecipe.text = "\(title)"
        infoRecipe.text = "\(count) Ingredients | \(minutes) min"
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
private extension RecentCategoryPreviewCell {
    
    var _recipeImageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }
    
    var _ratingView: UIView {
        let view = UIView()
        view.layer.cornerRadius = 10
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true
        blurView.alpha = 0.4
        view.addSubview(blurView)
        return view
    }
    
    var _ratingLabel: UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        return label
    }
    
    var _ratingImageView: UIImageView {
        let smallFont = UIFont.systemFont(ofSize: 12)
        let configuration = UIImage.SymbolConfiguration(font: smallFont)
        let image = UIImage(systemName: "star.fill", withConfiguration: configuration)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        return imageView
    }
    
    var _titleRecipe: UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.poppinsSemiBold(size: 14)
        label.textColor = .black
        return label
    }
    
    var _infoRecipe: UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.poppinsRegular(size: 12)
        label.textColor = .white
        return label
    }
}
