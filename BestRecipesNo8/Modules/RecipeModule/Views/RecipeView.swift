//
//  RecipeView.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 28.08.23.
//

import UIKit
import SnapKit
import Kingfisher

final class RecipeView: UIViewController {
    
    private let presenter: RecipePresenter
    
    // MARK: - Views
    private lazy var scrollView: UIScrollView = _scrollView
    private lazy var contentView: UIView = _contentView
    
    private lazy var titleRecipe: UILabel = _titleRecipe
    private lazy var dishImageView: UIImageView = _dishImageView
    
    private lazy var ratingStackView: UIStackView = _ratingStackView
    private lazy var ratingIcon: UIImageView = _ratingIcon
    private lazy var ratingLabel: UILabel = _ratingLabel
    private lazy var reviewsLabel: UILabel = _reviewsLabel
    
    private lazy var instructionsTitle: UILabel = _instructionsTitle
    private lazy var instructionsTextView: UITextView = _instructionsTextView
    
    private lazy var ingredientsTitle: UILabel = _ingredientsTitle
    private lazy var countIngredientsLabel: UILabel = _countIngredientsLabel
    private lazy var ingredientsTableView: UITableView = _ingredientsTableView
    
    private let heightOfTableView: Int
    
    // MARK: - Init
    init(presenter: RecipePresenter) {
        self.presenter = presenter
        heightOfTableView = Int(presenter.heightOfTableViewCell) * presenter.countIngredients
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setupNavigationBar()
        
        setupSubviews()
        applyConstraints()
        setupRecipeContent()
    }
    
    // MARK: - Setup content of chosen page
    func setupRecipeContent() {
        titleRecipe.text = presenter.getTitleRecipe
//        dishImageView.image = UIImage(named: "dishImg")
        ratingLabel.text = presenter.getRatingText
        reviewsLabel.text = presenter.getReviewsText
        instructionsTextView.attributedText = getInstructionsText()
        let url = presenter.recipe.image
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(1)
        let processor = RoundCornerImageProcessor(cornerRadius: 55, backgroundColor: .clear)
        dishImageView.kf.indicatorType = .activity
        dishImageView.kf.setImage(with: URL(string: url!), placeholder: nil, options: [.processor(processor),
                                                                                       .cacheSerializer(FormatIndicatedCacheSerializer.png)])
    }
    
    // MARK: - Subviews
    private func setupSubviews() {
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        contentView.addSubview(titleRecipe)
        contentView.addSubview(dishImageView)
        
        ratingStackView.addArrangedSubview(ratingIcon)
        ratingStackView.addArrangedSubview(ratingLabel)
        ratingStackView.addArrangedSubview(reviewsLabel)
        contentView.addSubview(ratingStackView)
        
        contentView.addSubview(instructionsTitle)
        contentView.addSubview(instructionsTextView)
        
        contentView.addSubview(ingredientsTitle)
        contentView.addSubview(countIngredientsLabel)
        contentView.addSubview(ingredientsTableView)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.snp.edges)
            make.width.equalTo(scrollView.snp.width)
        }
        
        titleRecipe.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(25)
        }
        
        dishImageView.snp.makeConstraints { make in
            make.top.equalTo(titleRecipe.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(210)
            make.width.equalTo(343)
        }
        
        ratingIcon.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        ratingStackView.snp.makeConstraints { make in
            make.top.equalTo(dishImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(25)
            make.trailing.greaterThanOrEqualToSuperview().inset(225)
            make.height.equalTo(20)
        }
        
        instructionsTitle.snp.makeConstraints { make in
            make.top.equalTo(ratingStackView.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(230)
        }
        
        instructionsTextView.snp.makeConstraints { make in
            make.top.equalTo(instructionsTitle.snp.bottom).offset(0)
            make.leading.trailing.equalToSuperview().inset(25)
        }
        
        ingredientsTitle.snp.makeConstraints { make in
            make.top.equalTo(instructionsTextView.snp.bottom).offset(0)
            make.leading.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(230)
        }
        
        countIngredientsLabel.snp.makeConstraints { make in
            make.top.equalTo(instructionsTextView.snp.bottom).offset(0)
            make.trailing.equalToSuperview().inset(30)
            make.leading.greaterThanOrEqualTo(ingredientsTitle.snp.trailing).inset(100)
        }
        
        ingredientsTableView.snp.makeConstraints { make in
            make.top.equalTo(ingredientsTitle.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(heightOfTableView)
        }
    }
    
    // MARK: - Make every Instruction as numbered list (The last line is without number and red color)
    func getInstructionsText() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: indentedParagraphStyle,
            .font: UIFont.poppinsRegular(size: 16)!
        ]
        let attributedInstructions = NSMutableAttributedString()

        let lines = presenter.getInstructions().split(separator: "\n")
        for (index, line) in lines.enumerated() {
            let numberString = "\(index + 1). "
            let lineString = "\(line)\n"
            
            let numberedLine = NSAttributedString(string: numberString + lineString, attributes: attributes)

            let attributedLine = index == lines.count - 1 ? makeLineRed(lineString) : numberedLine
            attributedInstructions.append(attributedLine)
        }

        return attributedInstructions
    }
    
    // make space for text
    var indentedParagraphStyle = { () -> NSParagraphStyle in
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 15
        return paragraphStyle
    }()
    
    // make the last line red color
    func makeLineRed(_ lineString: String) -> NSAttributedString {
        let redAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.red,
            .font: UIFont.poppinsRegular(size: 16)!
        ]
        let lastLine = NSAttributedString(string: lineString, attributes: redAttributes)
        return lastLine
    }
}

// MARK: - UITableView Protocols
extension RecipeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countIngredients
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.reuseIdentifier, for: indexPath) as! IngredientCell
        
        countIngredientsLabel.text = presenter.getCountIngredientsText
        let ingredient = presenter.getIngredient(at: indexPath.row)
        cell.updateCell(at: indexPath.row, ingredient: ingredient)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.heightOfTableViewCell
    }
}

extension RecipeView: RecipeViewInput {
    func openRecipe() {
        print("Recipe is opened")
    }
}

// MARK: - Extension for setup elements
private extension RecipeView {
    
    var _scrollView: UIScrollView {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }
    
    var _contentView: UIView {
        let view = UIView()
        return view
    }
    
    var _titleRecipe: UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.poppinsSemiBold(size: 24)
        label.textColor = .black
        return label
    }
    
    var _dishImageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }
    
    var _ratingStackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }
    
    var _ratingIcon: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "starIcon")
        return imageView
    }
    
    var _ratingLabel: UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.poppinsSemiBold(size: 14)
        label.textColor = .black
        return label
    }
    
    var _reviewsLabel: UILabel {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.textColor = .neutralColor50
        return label
    }
    
    var _instructionsTitle: UILabel {
        let label = UILabel()
        label.text = "Instructions"
        label.font = UIFont.poppinsSemiBold(size: 20)
        label.textColor = .black
        return label
    }
    
    var _instructionsTextView: UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textColor = .black
        return textView
    }
    
    var _ingredientsTitle: UILabel {
        let label = UILabel()
        label.text = "Ingredients"
        label.font = UIFont.poppinsSemiBold(size: 20)
        label.textColor = .black
        return label
    }
    
    var _countIngredientsLabel: UILabel {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.textColor = .neutralColor50
        return label
    }
    
    var _ingredientsTableView: UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.reuseIdentifier)
        return tableView
    }
}
