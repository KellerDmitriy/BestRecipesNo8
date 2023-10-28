//
//  HeaderSupplementaryView.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import UIKit

class HeaderSupplementaryView: UICollectionReusableView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.textAlignment = .left
        label.font = UIFont.poppinsSemiBold(size: 20)
        label.textColor = .black
        return label
    }()

    
    lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
            config.title = "See all "
            config.image = UIImage(systemName: "arrow.right")
            config.imagePlacement = .trailing
            config.baseForegroundColor = .orange
        button.configuration = config
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var isButtonHidden = false {
       didSet {
           seeAllButton.isHidden = isButtonHidden
       }
   }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(headerLabel)
        addSubview(seeAllButton)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureHeader(category: String) {
        headerLabel.text = category
    }
    
    func applyConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
    }
}
