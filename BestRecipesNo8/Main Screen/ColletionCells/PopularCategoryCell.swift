//
//  popularCategoryCell.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 29.08.2023.
//

import UIKit

final class PopularCategoryCell: UICollectionViewCell {
    
    //MARK: - UI Elements:
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "shawerma")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var grayBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            grayBackgroundView.heightAnchor.constraint(equalToConstant: 176),
            grayBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            grayBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            grayBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
