//
//  PopularCategoryHeaderCell.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 02.09.2023.
//

import UIKit

final class PopularCategoryHeaderCell: UICollectionViewCell {
    
    //MARK: - UI Elements:
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont(name: "Poppins-Regular", size: 8)
        label.textAlignment = .center
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        contentView.addSubview(headerLabel)
        contentView.backgroundColor = UIColor(named: "Primary")
        contentView.layer.cornerRadius = 10
    }
    
    func configureCell(header: String) {
        headerLabel.text = header
    }
    
    func selectCell() {
        contentView.backgroundColor = UIColor(named: "Primary")
        headerLabel.textColor = .white
    }
    
    func diselectCell() {
        contentView.backgroundColor = .clear
        headerLabel.textColor = UIColor(named: "Primary")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            headerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
