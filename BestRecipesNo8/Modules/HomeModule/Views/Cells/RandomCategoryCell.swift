//
//  RandomCategoryCell.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import UIKit
import Kingfisher

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
    func configureCell(at recipeInfo: RecipeProtocol) {
        let id = recipeInfo.id
        guard
              let title = recipeInfo.title,
              let image = recipeInfo.image else { return }
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(1)
        let processor = RoundCornerImageProcessor(cornerRadius: 12, backgroundColor: .clear)
        recipeImageView.kf.indicatorType = .activity
        recipeImageView.kf.setImage(with: URL(string: image), placeholder: nil, options: [.processor(processor),
                                                                                          .cacheSerializer(FormatIndicatedCacheSerializer.png)])
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
