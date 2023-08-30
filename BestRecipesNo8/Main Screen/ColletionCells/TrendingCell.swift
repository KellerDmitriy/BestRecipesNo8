//
//  TrendingCollectionCell.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 28.08.2023.
//

import UIKit

final class TrendingCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    
    private lazy var imageView: UIImageView = {
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
    
    private lazy var menuButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "More")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var creatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "creator")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var creatorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "By Zeelicious foods"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.tintColor = .gray
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.setImage(UIImage(named: "Inactive"), for: .normal)
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
        addSubview(imageView)
        addSubview(titleLabel)
        contentView.addSubview(menuButton)
        addSubview(creatorImageView)
        addSubview(creatorLabel)
        imageView.addSubview(addButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            
            menuButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            menuButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            creatorImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            creatorImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            creatorLabel.centerYAnchor.constraint(equalTo: creatorImageView.centerYAnchor),
            creatorLabel.leadingAnchor.constraint(equalTo: creatorImageView.trailingAnchor, constant: 10),
            
            addButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            addButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            addButton.heightAnchor.constraint(equalToConstant: 32),
            addButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
}
