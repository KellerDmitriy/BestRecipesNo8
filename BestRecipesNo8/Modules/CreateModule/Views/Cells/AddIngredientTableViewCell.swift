//
//  AddIngredientTableViewCell.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 10.09.2023.
//

import UIKit

class AddIngredientTableViewCell: UITableViewCell {
    
    static let cellID = String(describing: AddIngredientTableViewCell.self)
    
    // MARK: - Properties
    
    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var addLabel: UILabel = {
        let label = UILabel()
        label.text = "Add new Ingredient"
        label.font = .poppinsSemiBold(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initial
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        contentView.addSubview(plusImageView)
        NSLayoutConstraint.activate([
            plusImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            plusImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        contentView.addSubview(addLabel)
        NSLayoutConstraint.activate([
            addLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            addLabel.leadingAnchor.constraint(equalTo: plusImageView.trailingAnchor, constant: 8)
        ])
    }
    
}
