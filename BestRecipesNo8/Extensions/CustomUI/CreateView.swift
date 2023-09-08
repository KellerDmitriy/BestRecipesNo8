//
//  CreateView.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 06.09.2023.
//

import UIKit

enum TitleView: String {
    case serves = "Serves"
    case cookTime = "Cook time"
}

enum ImageView: String {
    case serves = "person.2.fill"
    case cookTime = "clock.fill"
}

class CreateView: UIView {
    
    // MARK: - Properties
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 16)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 16)
        label.text = "0"
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initial
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.9450979829, green: 0.9450979829, blue: 0.9450981021, alpha: 1)
        layer.cornerRadius = 10
        
        addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalToConstant: 36),
            backgroundView.heightAnchor.constraint(equalToConstant: 36),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        ])
        
        backgroundView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -8),
            imageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8)
        ])
        
        addSubview(title)
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            title.leadingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 16)
        ])
        
        addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            button.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        addSubview(countLabel)
        NSLayoutConstraint.activate([
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            countLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -8)
        ])
    }
    
    // MARK: - Public Methods
    func congigureView(with image: ImageView, and title: TitleView) {
        let image = UIImage(systemName: image.rawValue)
        self.imageView.image = image
        self.title.text = title.rawValue
        switch title {
        case .serves:
            countLabel.text = "0"
        case .cookTime:
            countLabel.text = "0 min"
        }
    }
    
}
