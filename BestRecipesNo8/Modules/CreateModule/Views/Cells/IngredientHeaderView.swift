//
//  IngredientHeaderView.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 06.09.2023.
//

import UIKit

class IngredientHeaderView: UITableViewHeaderFooterView {
    
    static let reuseID = String(describing: IngredientHeaderView.self)
    
    private lazy var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .poppinsSemiBold(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(ingredientsLabel)
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            ingredientsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
}
