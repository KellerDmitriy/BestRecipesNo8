//
//  HeaderSupplementaryView.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import UIKit

protocol HeaderSupplementaryViewDelegate: AnyObject {
    func didTapButton(inSection section: Int)
}

class HeaderSupplementaryView: UICollectionReusableView {
    
    weak var delegate: HeaderSupplementaryViewDelegate?
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.textAlignment = .left
        label.font = UIFont.poppinsSemiBold(size: 20)
        label.textColor = .black
        return label
    }()
    
    var isButtonHidden = false {
       didSet {
           seeAllButton.isHidden = isButtonHidden
       }
   }
    
    lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = "See all "
        config.image = UIImage(systemName: "arrow.right")
        config.imagePlacement = .trailing
        config.baseForegroundColor = .black
        let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.poppinsSemiBold(size: 14)!,
                .foregroundColor: UIColor.darkRedColor
            ]
        let attributedTitle = NSAttributedString(string: "See all ", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
            
        button.configuration = config
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
    }()
    
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
    
    @objc private func seeAllButtonTapped() {
        delegate?.didTapButton(inSection: self.tag)
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
