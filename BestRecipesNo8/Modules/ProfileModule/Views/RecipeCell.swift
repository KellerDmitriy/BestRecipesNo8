//
//  RecipeCell.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 1.09.23.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    static let cellID = String(describing: RecipeCell.self)
    
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
    func updateRecipeData(image: UIImage?, rating: Double, title: String, count: Int, minutes: String) {
        recipeImageView.image = image
        ratingLabel.text = String(rating)
        titleRecipe.text = "How to make yam\n& \(title) at home"
        infoRecipe.text = "\(count) Ingredients | \(minutes) min"
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        contentView.addSubview(recipeImageView)
        
        ratingView.addSubview(ratingImageView)
        ratingView.addSubview(ratingLabel)
        contentView.addSubview(ratingView)
        
        contentView.addSubview(infoRecipe)
        contentView.addSubview(titleRecipe)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        
        recipeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        ratingImageView.snp.makeConstraints { make in
            make.width.height.equalTo(14)
            make.centerY.equalTo(ratingView)
            make.leading.equalTo(ratingView).offset(8)
        }

        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingView)
            make.trailing.equalTo(ratingView).offset(-8)
        }

        ratingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(58)
            make.height.equalTo(27)
        }

        infoRecipe.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }

        titleRecipe.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(infoRecipe.snp.top).offset(-8)
        }
    }
}

// MARK: - Extension for setup elements
private extension RecipeCell {
    
    var _recipeImageView: UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        imageView.contentMode = .scaleAspectFill

        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.addBottomShadow()
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
        label.font = UIFont.poppinsSemiBold(size: 16)
        label.textColor = .white
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
