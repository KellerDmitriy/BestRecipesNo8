//
//  IngredientTableViewCell.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 10.09.2023.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    static let cellID = String(describing: IngredientTableViewCell.self)
    
    // MARK: Properties
    
    private lazy var separatorView = UIView()
    
    lazy var nameIngredient: CreateTextField = {
        let tf = CreateTextField()
        tf.placeholder = "Item name"
        tf.layer.cornerRadius = 10
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        tf.autocorrectionType = .no
        tf.returnKeyType = .next
        tf.smartInsertDeleteType = .no
        tf.smartQuotesType = .no
        tf.adjustsFontSizeToFitWidth = true
        tf.tag = 1
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var quantityIngredient: CreateTextField = {
        let tf = CreateTextField()
        tf.placeholder = "Quantity"
        tf.layer.cornerRadius = 10
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        tf.autocorrectionType = .no
        tf.returnKeyType = .done
        tf.smartInsertDeleteType = .no
        tf.smartQuotesType = .no
        tf.adjustsFontSizeToFitWidth = true
        tf.tag = 2
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var deleteIngredientButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus.square"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initial
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        contentView.addSubview(nameIngredient)
        NSLayoutConstraint.activate([
            nameIngredient.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            nameIngredient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            nameIngredient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            nameIngredient.widthAnchor.constraint(equalToConstant: 164)
        ])
        
        contentView.addSubview(deleteIngredientButton)
        NSLayoutConstraint.activate([
            deleteIngredientButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            deleteIngredientButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            deleteIngredientButton.widthAnchor.constraint(equalToConstant: 24),
            deleteIngredientButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        contentView.addSubview(quantityIngredient)
        NSLayoutConstraint.activate([
            quantityIngredient.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            quantityIngredient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            quantityIngredient.leadingAnchor.constraint(equalTo: nameIngredient.trailingAnchor, constant: 12),
            quantityIngredient.trailingAnchor.constraint(equalTo: deleteIngredientButton.leadingAnchor, constant: -12)
        ])
        
    }
    
    // MARK: - Configure Cell
    
    func configureCell(for indexPath: IndexPath) {
        deleteIngredientButton.tag = indexPath.row
    }

}
