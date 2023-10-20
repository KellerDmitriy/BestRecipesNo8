//
//  RecentRecipeCell.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 30.08.2023.
//

import UIKit
import Kingfisher

final class RecentRecipeCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Salad")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 14)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.text = "How to sharwama at home"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - LifeCycle:
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods:
    
    private func setupUI() {
        addSubview(recipeImageView)
        addSubview(titleLabel)
    }
    
    func configureCell(at recipeInfo: RecipeProtocol) {
        let id = recipeInfo.id
        guard let title = recipeInfo.title,
              let image = recipeInfo.image else { return }
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(1)
        let processor = RoundCornerImageProcessor(cornerRadius: 12, backgroundColor: .clear)
        recipeImageView.kf.indicatorType = .activity
        recipeImageView.kf.setImage(with: URL(string: image), placeholder: nil, options: [.processor(processor),
                                                                                          .cacheSerializer(FormatIndicatedCacheSerializer.png)])
        titleLabel.text = title
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeImageView.widthAnchor.constraint(equalTo: widthAnchor),
            recipeImageView.heightAnchor.constraint(equalTo: widthAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 8),
            
        ])
    }
}

