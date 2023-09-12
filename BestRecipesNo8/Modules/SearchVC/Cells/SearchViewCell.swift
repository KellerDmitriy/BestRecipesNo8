//
//  SearchViewCell.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 07.09.2023.
//


import UIKit
import Kingfisher

final class SearchViewCell: UITableViewCell {
    
    static let cellID = String(describing: SearchViewCell.self)
    
    private let recipeImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .poppinsBold(size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var addButton = CustomAddButton()
    
    var isSaved = false {
        didSet {
            addButton.toggle(with: isSaved)
        }
    }
    var addButtonClosure: (() -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addButtonSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public methods
    func configure(model: SearchRecipe) {
        
        guard let title = model.title, let image = model.image else { return }
        recipeNameLabel.text = title
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(1)
        let processor = RoundCornerImageProcessor(cornerRadius: 55, backgroundColor: .clear)
        recipeImageView.kf.indicatorType = .activity
        recipeImageView.kf.setImage(with: URL(string: image))
//        isSaved = RealmDataBase.shared.isItemSaved(withId: model.id)
       // self.addButtonClosure = addButtonClosure
    }
}
// MARK: - setupUI
private extension SearchViewCell {
    
    func setupUI() {
        setupView()
        setConstraints()
    }
    
    func setupView() {
        clipsToBounds = true
        contentView.addSubview(recipeImageView)
        contentView.addSubview(recipeNameLabel)
        contentView.addSubview(addButton)
    }
    
    func setConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.height.equalTo(200)
        }
        
        recipeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
            make.trailing.equalTo(contentView.snp.trailing)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.top).offset(10)
            make.trailing.equalTo(recipeImageView.snp.trailing).offset(-10)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
    }
}
//  MARK: - Save button setup

extension SearchViewCell {
    
    private func addButtonSetup() {
        addButton.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
        addButtonClosure?()
        isSaved.toggle()
    }
}
