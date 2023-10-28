//
//  PopularCell.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import UIKit

class PopularCategoryCell: UICollectionViewCell {
    
    static let cellID = String(describing: PopularCategoryCell.self)
    
    // MARK: - Views
    private lazy var categoryTitle: UILabel = _categoryTitle
    var didSelectCategoryHandler: ((String) -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellAppearance()
        
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellAppearance() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
    }
    
    func configureCell(title: String) {
        categoryTitle.text = title
        
    }
    
    //MARK: - Update data of popular recipes and change color of selected cell
    
    func selectCell(_ index: Int) {
        contentView.backgroundColor = .darkRedColor
        categoryTitle.textColor = .white
        if let category = categoryTitle.text {
            didSelectCategoryHandler?(category)
        }
    }
    
    func deselectCell() {
        contentView.backgroundColor = .clear
        categoryTitle.textColor = .primaryColor20
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        contentView.addSubview(categoryTitle)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        categoryTitle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - Extension for setup elements
private extension PopularCategoryCell {
    
    var _categoryTitle: UILabel {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 12)
        label.textColor = .primaryColor
        return label
    }
}
