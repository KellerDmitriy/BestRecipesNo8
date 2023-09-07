//
//  popularCategoryCell.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 29.08.2023.
//

import UIKit
import Kingfisher

final class PopularCategoryCell: UICollectionViewCell {
    
    weak var delegate: PopularCategoryDelegate?
    private var recipe: RecipeInfo?
    private var isSaved: Bool = false
    
    //MARK: - UI Elements:
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "shawerma")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 55
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var grayBackgroundView: UIView = {
        let view = UIView()
            //MARK: TODO: - Разобраться почему не подключается цвет из экстеншена
        view.backgroundColor = UIColor(named: "Neutral")
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.text = "Chicken and Vegetable wrap"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "Time"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 12)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "5 Mins"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.tintColor = .gray
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setImage(UIImage(named: "Union"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        contentView.addSubview(grayBackgroundView)
        contentView.addSubview(recipeImageView)
        grayBackgroundView.addSubview(titleLabel)
        grayBackgroundView.addSubview(timeLabel)
        grayBackgroundView.addSubview(counterLabel)
        grayBackgroundView.addSubview(addButton)
    }
    
    func configureCell(at recipeInfo: RecipeInfo, delegate: PopularCategoryDelegate) {
        guard let id = recipeInfo.id,
              let title = recipeInfo.title,
              let image = recipeInfo.image
//              let readyInMinutes =  recipeInfo.readyInMinutes
        else { return }
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(1)
        let processor = RoundCornerImageProcessor(cornerRadius: 55, backgroundColor: .clear)
        recipeImageView.kf.indicatorType = .activity
        recipeImageView.kf.setImage(with: URL(string: image), placeholder: nil, options: [.processor(processor),
                                                                                          .cacheSerializer(FormatIndicatedCacheSerializer.png)])
        titleLabel.text = title
       // counterLabel.text = "\(readyInMinutes) Mins"
        self.delegate = delegate
        self.recipe = recipeInfo
        self.isSaved = delegate.isRecipeSaved(recipe: recipeInfo)
        setAddButtonColor()
    }
    
    private func setAddButtonColor() {
        addButton.tintColor = isSaved ? .red : .gray
    }
    
    @objc
    private func addButtonTapped() {
        guard let recipe else { return }
        delegate?.updateSavedRecipes(recipe: recipe)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: 110),
            recipeImageView.widthAnchor.constraint(equalToConstant: 110),
            
            grayBackgroundView.heightAnchor.constraint(equalToConstant: 176),
            grayBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            grayBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            grayBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: grayBackgroundView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(
                equalTo: grayBackgroundView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: grayBackgroundView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: grayBackgroundView.trailingAnchor),
            
            timeLabel.leadingAnchor.constraint(equalTo: grayBackgroundView.leadingAnchor, constant: 12),
            timeLabel.bottomAnchor.constraint(equalTo: grayBackgroundView.bottomAnchor, constant: -33),
            
            counterLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            counterLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            
            addButton.trailingAnchor.constraint(equalTo: grayBackgroundView.trailingAnchor, constant: -12),
            addButton.bottomAnchor.constraint(equalTo: grayBackgroundView.bottomAnchor, constant: -12),
            addButton.heightAnchor.constraint(equalToConstant: 24),
            addButton.widthAnchor.constraint(equalToConstant: 24)
            
        ])
    }
}
