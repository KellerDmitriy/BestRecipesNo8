//
//  IngredientCell.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 29.08.23.
//

import UIKit
import Kingfisher

class IngredientCell: UITableViewCell {
    
    static let reuseIdentifier = "IngredientCell"
    
    // MARK: - Views
    private lazy var cellView: UIView = _cellView
    
    private lazy var iconView: UIView = _iconView
    private lazy var icon: UIImageView = _icon
    private lazy var nameLabel: UILabel = _nameLabel
    
    private lazy var countLabel: UILabel = _countLabel
    private lazy var checkboxButton: UIButton = _checkboxButton
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellAppearance()
        setupSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup cell appearance when it inited
    private func setupCellAppearance() {
        backgroundColor = .white
        selectionStyle = .none
    }
    
    // MARK: - Subviews
    private func setupSubviews() {
        iconView.addSubview(icon)
        cellView.addSubview(iconView)
        cellView.addSubview(nameLabel)
        cellView.addSubview(countLabel)
        cellView.addSubview(checkboxButton)
        contentView.addSubview(cellView)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        icon.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(52)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(130)
        }
        
        checkboxButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(23)
            make.centerY.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints { make in
            make.trailing.equalTo(checkboxButton.snp.leading).offset(-25)
            make.centerY.equalToSuperview()
        }
        
        cellView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    // MARK: - Checkbox Button Method
    @objc private func checkboxIsTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    // MARK: - Method for setup elements in every cell
    func updateCell(at index: Int, ingredient: IngredientModel) {
        // icon.image = ingredient.
        nameLabel.text = ingredient.name
        countLabel.text = ingredient.count
        
        let url = ingredient.iconURL
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(1)
        let processor = RoundCornerImageProcessor(cornerRadius: 55, backgroundColor: .clear)
        icon.kf.indicatorType = .activity
        icon.kf.setImage(with: URL(string: url), placeholder: nil, options: [.processor(processor),
                                                                                       .cacheSerializer(FormatIndicatedCacheSerializer.png)])
    }
}

// MARK: - Extension for setup elements
private extension IngredientCell {
    
    var _cellView: UIView {
        let view = UIView()
        view.backgroundColor = .neutralColor10
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }
    
    var _iconView: UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }
    
    var _icon: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    var _nameLabel: UILabel {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 16)
        label.textColor = .black
        return label
    }
    
    var _countLabel: UILabel {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.textColor = .neutralColor50
        return label
    }
    
    var _checkboxButton: UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "checkbox"), for: .normal)
        button.setImage(UIImage(named: "selectedCheckbox"), for: .selected)
        button.addTarget(self, action: #selector(checkboxIsTapped), for: .touchUpInside)
        return button
    }
}
