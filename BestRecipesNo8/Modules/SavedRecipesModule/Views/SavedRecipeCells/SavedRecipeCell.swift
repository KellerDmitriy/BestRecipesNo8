//
//  SavedRecipeCell.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import UIKit
import Kingfisher

class SavedRecipeCell: UITableViewCell {
    
    static let cellID = String(describing: SavedRecipeCell.self)
    
    // MARK: - Views
    private lazy var recipeImageView: UIImageView = _recipeImageView
    private lazy var titleRecipe: UILabel = _titleRecipe
    
    private lazy var ratingView: UIView = _ratingView
    private lazy var ratingLabel: UILabel = _ratingLabel
    private lazy var ratingImageView: UIImageView = _ratingImageView
    
    private lazy var timeCreationView: UIView = _timeCreationView
    private lazy var timeLabel: UILabel = _timeLabel
    
    private lazy var bookmarkView: UIView = _bookmarkView
    private lazy var bookmarkImageView: UIImageView = _bookmarkImageView
    
    // MARK: - Init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method for setup data to elements in every cell
    func updateRecipeData(image: String?, rating: Int?, title: String?, time: Int?) {
        if let rating = rating {
            ratingLabel.text = String(rating)
        } else {
            ratingLabel.text = "N/A"
        }
        titleRecipe.text = "How to make \(title ?? "") at home"
        if let time = time {
            timeLabel.text = String(time)
        } else {
            timeLabel.text = "N/A"
        }
        guard let url = image else { return }
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(1)
        let processor = RoundCornerImageProcessor(cornerRadius: 12, backgroundColor: .clear)
        recipeImageView.kf.indicatorType = .activity
        recipeImageView.kf.setImage(with: URL(string: url), placeholder: nil, options: [.processor(processor),
                                                                                          .cacheSerializer(FormatIndicatedCacheSerializer.png)])
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleRecipe)
        
        ratingView.addSubview(ratingImageView)
        ratingView.addSubview(ratingLabel)
        contentView.addSubview(ratingView)
        
        bookmarkView.addSubview(bookmarkImageView)
        contentView.addSubview(bookmarkView)
        
        timeCreationView.addSubview(timeLabel)
        contentView.addSubview(timeCreationView)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        
        recipeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleRecipe.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
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
        
        timeCreationView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
            make.width.equalTo(41)
            make.height.equalTo(25)
        }

        timeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        bookmarkView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
            make.width.height.equalTo(32)
        }

        bookmarkImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
}

// MARK: - Extension for setup elements
private extension SavedRecipeCell {
    
    var _recipeImageView: UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
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
        label.font = UIFont.poppinsSemiBold(size: 16)
        label.textColor = .black
        return label
    }
    
    var _timeCreationView: UIView {
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
    
    var _timeLabel: UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.poppinsRegular(size: 12)
        label.textColor = .white
        return label
    }
    
    var _bookmarkView: UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        view.backgroundColor = .white
        view.makeCircular()
        return view
    }
    
    var _bookmarkImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage.bookmarkSelect
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
