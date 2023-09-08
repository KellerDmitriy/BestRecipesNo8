//
//  SearchViewCell.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 07.09.2023.
//


import UIKit
import Kingfisher

final class SearchViewCell: UITableViewCell {
    
    static let cellID = String(describing: SearchViewCell.self)
    
    // MARK: - Private properties
    
    // Изображение
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Рейтинг
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "5,0"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingImage: UIImageView = {
        let smallFont = UIFont.systemFont(ofSize: 12)
        let configuration = UIImage.SymbolConfiguration(font: smallFont)
        let image = UIImage(systemName: "star.fill", withConfiguration: configuration)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true
        //        blurView.layer.shouldRasterize = true
        view.addSubview(blurView)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Информация о рецепте
    
    private lazy var titleRecipe: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.poppinsBold(size: 16)
        label.textColor = .white
        label.text = "How to make yam & vegetable sauce at home"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoRecipe: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.poppinsRegular(size: 12)
        label.textColor = .white
        label.text = "9 Ingredients | 25 min"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .lightGray
        contentView.clipsToBounds = true
        
        contentView.addSubview(recipeImageView)
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
        
        // Рейтинг
        ratingView.addSubview(ratingImage)
        NSLayoutConstraint.activate([
            ratingImage.widthAnchor.constraint(equalToConstant: 14),
            ratingImage.heightAnchor.constraint(equalToConstant: 14),
            ratingImage.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor, constant: 0),
            ratingImage.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor, constant: 8)
        ])
        
        ratingView.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor, constant: 0),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: -8)
        ])
        
        contentView.addSubview(ratingView)
        NSLayoutConstraint.activate([
            ratingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            ratingView.widthAnchor.constraint(equalToConstant: 58),
            ratingView.heightAnchor.constraint(equalToConstant: 27)
        ])
        
        contentView.addSubview(infoRecipe)
        NSLayoutConstraint.activate([
            infoRecipe.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            infoRecipe.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            infoRecipe.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        contentView.addSubview(titleRecipe)
        NSLayoutConstraint.activate([
            titleRecipe.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleRecipe.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            titleRecipe.bottomAnchor.constraint(equalTo: infoRecipe.topAnchor, constant: -8)
        ])
        
    }
    
    // MARK: - Public methods

    func configureCell(recipe: SearchRecipe) {
        let image = recipe.image ?? ""
        let title = recipe.title
        
        titleRecipe.text = title
        
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(1)
        let processor = RoundCornerImageProcessor(cornerRadius: 55, backgroundColor: .clear)
        recipeImageView.kf.indicatorType = .activity
        recipeImageView.kf.setImage(with: URL(string: image), placeholder: nil, options: [.processor(processor),
                                                                                          .cacheSerializer(FormatIndicatedCacheSerializer.png)])
        
    }
    
}
