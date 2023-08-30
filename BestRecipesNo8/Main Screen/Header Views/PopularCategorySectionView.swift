//
//  PopularCategorySectionView.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 30.08.2023.
//

import UIKit

final class PopularCategorySectionView: UIView {
    //MARK: - UIElements:
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular category "
        label.font = UIFont(name: "Poppins-Bold", size: 20)
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
        backgroundColor = .clear
        addSubview(titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
}
