//
//  TrendingNowView.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Garipov on 29.08.2023.
//

import UIKit

final class TrendingNowView: UIView {
    
    //MARK: - UIElements:
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending now 🔥"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
            config.title = "See all "
            config.image = UIImage(systemName: "arrow.right")
            config.imagePlacement = .trailing
            config.baseForegroundColor = .orange
        button.configuration = config
        
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
        backgroundColor = .clear
        addSubview(titleLabel)
        addSubview(seeAllButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            seeAllButton.topAnchor.constraint(equalTo: topAnchor),
            seeAllButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
