//
//  PopularCell.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import UIKit

class PopularCategoryPreviewCell: UICollectionViewCell {
    
    static let cellID = String(describing: PopularCategoryPreviewCell.self)
    
    // MARK: - Views
    private lazy var categoryTitle: UILabel = _categoryTitle

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
    
    func updateCategoryData(title: String) {
        categoryTitle.text = title
    }
    
    func selectCell() {
        contentView.backgroundColor = .darkRedColor
        categoryTitle.textColor = .white
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
    
    func changeButtonAppearance(for button: UIButton, selected: Bool) {
        button.backgroundColor = selected ? UIColor.systemRed : UIColor.white
        button.setTitleColor(selected ? UIColor.black : UIColor.primaryColor, for: .normal)
    }

}

// MARK: - Extension for setup elements
private extension PopularCategoryPreviewCell {
    
    var _categoryTitle: UILabel {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 12)
        label.textColor = .primaryColor
        return label
    }
}
