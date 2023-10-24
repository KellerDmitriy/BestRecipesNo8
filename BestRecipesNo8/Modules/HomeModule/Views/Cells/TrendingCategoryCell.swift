//
//  TrendingCategoryCell.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import UIKit
import Kingfisher

class TrendingCategoryCell: UICollectionViewCell {
    
    static let cellID = String(describing: TrendingCategoryCell.self)
    
    // MARK: - Views
    private lazy var recipeImageView: UIImageView = _recipeImageView
    private lazy var titleRecipe: UILabel = _titleRecipe
    
    private lazy var ratingView: UIView = _ratingView
    private lazy var ratingLabel: UILabel = _ratingLabel
    private lazy var ratingImageView: UIImageView = _ratingImageView
    
    private lazy var bookmarkView: UIView = _bookmarkView
    private lazy var bookmarkImageView: UIImageView = _bookmarkImageView
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBookmark()
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method for setup data to elements in every cell
    func updateRecipeData(at recipe: RecipeProtocol) {
        let id = recipe.id
        guard let title = recipe.title,
              let image = recipe.image,
              let rating = recipe.rating
        else { return }
        
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(1)
        let processor = RoundCornerImageProcessor(cornerRadius: 12, backgroundColor: .clear)
        recipeImageView.kf.indicatorType = .activity
        recipeImageView.kf.setImage(with: URL(string: image), placeholder: nil, options: [.processor(processor),
                                                                                          .cacheSerializer(FormatIndicatedCacheSerializer.png)])
        titleRecipe.text = "How to make \(title) at home"
        ratingLabel.text = "\(rating)"
    }
    
    func setupBookmark() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bookmarkIsTapped))
        bookmarkView.addGestureRecognizer(tapGesture)
    }
    
    private var bookmarkIsSelected = false
    
    @objc func bookmarkIsTapped() {
        bookmarkIsSelected.toggle()
        bookmarkImageView.image = bookmarkIsSelected ? UIImage.bookmarkSelect : UIImage.bookmark
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleRecipe)
        
        ratingView.addSubview(ratingImageView)
        ratingView.addSubview(ratingLabel)
        recipeImageView.addSubview(ratingView)
        
        bookmarkView.addSubview(bookmarkImageView)
        recipeImageView.addSubview(bookmarkView)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        
        recipeImageView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(200)
            make.centerX.centerY.equalToSuperview()
        }
        
        titleRecipe.snp.makeConstraints { make in
            make.width.equalTo(recipeImageView.snp.width)
            make.centerX.equalToSuperview()
            make.top.equalTo(recipeImageView.snp.bottom).offset(15)
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
        
        bookmarkView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
            make.width.height.equalTo(32)
        }
        
        bookmarkImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(21)
        }
    }
}

// MARK: - Extension for setup elements
private extension TrendingCategoryCell {
    
    var _recipeImageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }
    
    var _titleRecipe: UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.poppinsSemiBold(size: 16)
        label.textColor = .black
        return label
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
    
    var _bookmarkView: UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.makeCircular()
        return view
    }
    
    var _bookmarkImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage.bookmark
        imageView.contentMode = .center
        return imageView
    }
}
