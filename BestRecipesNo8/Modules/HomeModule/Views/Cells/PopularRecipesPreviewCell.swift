//
//  PopularRecipesPreviewCell.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 7.09.23.
//

import UIKit

class PopularRecipesPreviewCell: UICollectionViewCell {
    
    static let cellID = String(describing: PopularRecipesPreviewCell.self)
    
    // MARK: - Views
    private lazy var recipeView: UIView = _recipeView
    private lazy var recipeImageView: UIImageView = _recipeImageView
    private lazy var titleRecipe: UILabel = _titleRecipe
    
    private lazy var timeTitleLabel: UILabel = _timeTitleLabel
    private lazy var timeLabel: UILabel = _timeLabel
    
    private lazy var bookmarkView: UIView = _bookmarkView
    private lazy var bookmarkImageView: UIImageView = _bookmarkImageView
    
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
    func updateRecipeData(image: UIImage?, title: String, time: Double?) {
        recipeImageView.image = image
        titleRecipe.text = "\(title)"
        timeLabel.text = "\(Int(time ?? 0)) Mins"
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        contentView.addSubview(recipeView)
        recipeView.addSubview(recipeImageView)
        recipeView.addSubview(titleRecipe)
        
        recipeView.addSubview(timeTitleLabel)
        recipeView.addSubview(timeLabel)
        
        bookmarkView.addSubview(bookmarkImageView)
        recipeView.addSubview(bookmarkView)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        
        recipeView.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(176)
            make.bottom.centerX.equalToSuperview()
        }
        
        recipeImageView.snp.makeConstraints { make in
            make.width.height.equalTo(110)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(recipeView.snp.top).inset(55)
        }

        titleRecipe.snp.makeConstraints { make in
            make.width.equalTo(recipeView.snp.width)
            make.centerX.equalToSuperview()
            make.top.equalTo(recipeImageView.snp.bottom).offset(10)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview().inset(12)
        }
        
        timeTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(timeLabel.snp.top).offset(-6)
            make.leading.equalToSuperview().inset(12)
        }
        
        bookmarkView.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(15)
            make.width.height.equalTo(32)
        }

        bookmarkImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(21)
        }
    }
}

// MARK: - Extension for setup elements
private extension PopularRecipesPreviewCell {
    
    var _recipeView: UIView {
        let view = UIView()
        view.backgroundColor = .neutralColor10
        view.layer.cornerRadius = 10
        return view
    }
    
    var _recipeImageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 55
        return imageView
    }
    
    var _titleRecipe: UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.poppinsSemiBold(size: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }
    
    var _timeTitleLabel: UILabel {
        let label = UILabel()
        label.text = "Time"
        label.font = UIFont.poppinsRegular(size: 12)
        label.textColor = .neutralColor50
        return label
    }
    
    var _timeLabel: UILabel {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 12)
        label.textColor = .black
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
        imageView.image = UIImage.bookmark
        imageView.contentMode = .center
        return imageView
    }
}
