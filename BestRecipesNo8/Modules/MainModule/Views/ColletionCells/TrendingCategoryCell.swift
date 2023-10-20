//
//  TrendingCollectionCell.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 28.08.2023.
//

import UIKit
import Kingfisher

final class TrendingCategoryCell: UICollectionViewCell {
    
    weak var delegate: PopularCategoryDelegate?
    private var recipe: RecipeProtocol?
    var isSaved = false {
        didSet {
            addButton.toggle(with: isSaved)
        }
    }
    //MARK: - UI Elements
    
    var addButton = CustomAddButton(isChecked: false)
    var addButtonClosure: (() -> ())?
    
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
        label.font = UIFont(name: "Poppins-Bold", size: 16)
        label.text = "How to sharwama at home"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    //MARK: - LifeCycle:
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        addButtonSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - Methods:
    
    private func setupUI() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(addButton)
    }
    
    func configureCell(at recipeInfo: RecipeProtocol, delegate: PopularCategoryDelegate, addButtonClosure: @escaping () -> ()) {
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
        
        self.addButtonClosure = addButtonClosure
        self.delegate = delegate
        self.recipe = recipeInfo
        self.isSaved = delegate.isRecipeSaved(recipe: recipeInfo)
    }
    
    
//    @objc private func addButtonTapped() {
//        guard let recipe else { return }
//        delegate?.updateSavedRecipes(recipe: recipe)
//    }
    
    private func addButtonSetup() {
        addButton.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
        if let recipe = self.recipe {
            delegate?.addButtonTapped(for: recipe)
            isSaved.toggle()
        }
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: 180),
            recipeImageView.widthAnchor.constraint(equalToConstant: 280),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 5),
            
            addButton.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -8),
            addButton.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 8),
            addButton.heightAnchor.constraint(equalToConstant: 32),
            addButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
}
