//
//  SavedRecipeCell.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 2.09.23.
//

import UIKit

class SavedRecipeCell: UITableViewCell {
    
    static let cellID = String(describing: SavedRecipeCell.self)
    
    // MARK: - Views
    
    private lazy var recipeImageView: UIImageView = _recipeImageView
    private lazy var titleRecipe: UILabel = _titleRecipe
    
    private lazy var ratingView: UIView = _ratingView
    private lazy var ratingLabel: UILabel = _ratingLabel
    
    private lazy var timeCreationView: UIView = _timeCreationView
    private lazy var timeLabel: UILabel = _timeLabel
    
    lazy var addButton = CustomAddButton(isChecked: true)
    
    var addButtonClosure: (() -> ())?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addButtonSetup()
        addSubviews()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Method for setup data to elements in every cell
    func configureSavedCell(
        image: Data,
        rating: String,
        title: String,
        time: Int,
        addButtonClosure: @escaping () -> ()
    )
    {
        self.recipeImageView.image = UIImage(data: image)
        self.ratingLabel.text = rating
        self.titleRecipe.text = "How to make: \"\(title)\" at home"
        self.timeLabel.text = "Preparation time: \(String(time)) min"
        
        self.addButtonClosure = addButtonClosure
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleRecipe)
        
        ratingView.addSubview(ratingLabel)
        contentView.addSubview(ratingView)
        
        timeCreationView.addSubview(timeLabel)
        contentView.addSubview(timeCreationView)
        contentView.addSubview(addButton)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        
        recipeImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.height.equalTo(200)
        }
        
        titleRecipe.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
            make.trailing.equalTo(contentView.snp.trailing)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingView)
            make.trailing.equalTo(ratingView).offset(-8)
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(58)
            make.height.equalTo(27)
        }
        
        timeCreationView.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(-32)
            make.trailing.equalTo(recipeImageView.snp.trailing).offset(-10)
            make.width.equalTo(150)
            make.height.equalTo(25)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.top).offset(10)
            make.trailing.equalTo(recipeImageView.snp.trailing).offset(-10)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
    }
}

// MARK: - Extension for setup elements
private extension SavedRecipeCell {
    
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
    
    private func addButtonSetup() {
        addButton.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
        addButtonClosure?()
    }
}
