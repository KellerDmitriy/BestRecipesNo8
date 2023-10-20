//
//  CustomAddButton.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 08.09.2023.
//

import UIKit

final class CustomAddButton: UIButton {
    
    lazy var bookmarkImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    convenience init(isChecked: Bool) {
        self.init(frame: .zero)
        bookmarkImageView.image = isChecked ? .bookmark : .bookmarkSelect
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 17.5
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bookmarkImageView)
        
        NSLayoutConstraint.activate([
            bookmarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            bookmarkImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bookmarkImageView.heightAnchor.constraint(equalToConstant: 19),
            bookmarkImageView.widthAnchor.constraint(equalToConstant: 15),
        ])
    }
    
    func toggle(with isChecked: Bool) {
        bookmarkImageView.image = isChecked ? UIImage(named: "deleteRecipe") : UIImage(named: "savedRecipe")
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
