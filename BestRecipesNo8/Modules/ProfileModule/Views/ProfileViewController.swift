//
//  ProfileView.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 1.09.23.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenter!
    private let recipes = ProfileModel.shared.getData()
    
    // MARK: - Views
    private lazy var scrollView: UIScrollView = _scrollView
    private lazy var contentView: UIView = _contentView
    
    private lazy var profileTitle: UILabel = _profileTitle
    private lazy var profileImageView: UIImageView = _profileImageView
    
    private lazy var recipesTitle: UILabel = _recipesTitle
    private lazy var collectionView: UICollectionView = _collectionView
    
    private var heightOfCollectionView: Int
    
    // MARK: - Init
    init() {
        heightOfCollectionView = 200 * recipes.count
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapedImageView()
        addSubviews()
        applyConstraints()
        navigationController?.setupNavigationBar()
    }
    
    // MARK: - Methods with Image
    
    private func addTapedImageView() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapRecognizer:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func imageTapped(tapRecognizer: UITapGestureRecognizer){
        alertImageView()
    }
    
    private func chooseImage(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    enum ImageLoad: String {
        case camera = "Camera"
        case photoLibrary = "Gallery"
        case cancel = "Cancel"
    }
    
    func setAlertAction(alert: UIAlertController, imageLoad: ImageLoad) {
        let action: UIAlertAction
        
        switch imageLoad {
        case .camera:
            action = UIAlertAction(title: imageLoad.rawValue, style: .default) { _ in
                self.chooseImage(source: .camera)
            }
        case .photoLibrary:
            action = UIAlertAction(title: imageLoad.rawValue, style: .default) { _ in
                self.chooseImage(source: .photoLibrary)
            }
        case .cancel:
            action = UIAlertAction(title: imageLoad.rawValue, style: .cancel, handler: nil)
        }
        
        action.setValue(UIColor.darkGray, forKey: "titleTextColor")
        alert.addAction(action)
    }
    
    private func alertImageView() {
        let alert = UIAlertController(title: nil, message: "Choose a way to upload a photo", preferredStyle: .alert)
        
        setAlertAction(alert: alert, imageLoad: .camera)
        setAlertAction(alert: alert, imageLoad: .photoLibrary)
        setAlertAction(alert: alert, imageLoad: .cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        contentView.addSubview(profileTitle)
        contentView.addSubview(profileImageView)
        contentView.addSubview(recipesTitle)
        contentView.addSubview(collectionView)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        profileTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(21)
        }

        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(profileTitle.snp.bottom).offset(28)
            make.leading.equalToSuperview().inset(21)
            make.width.height.equalTo(100)
        }
        
        recipesTitle.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(68)
            make.leading.equalToSuperview().inset(36)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(recipesTitle.snp.bottom).offset(23)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(heightOfCollectionView)
        }
    }
    
    
    // MARK: - UICollectionViewCompositionalLayout
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.cellID, for: indexPath) as! RecipeCell
        
        let recipe = recipes[indexPath.row]
        cell.updateRecipeData(
            image: recipe.recipeImage,
            rating: recipe.rating,
            title: recipe.recipeName,
            count: recipe.countIngredients,
            minutes: recipe.timeCooking
        )
        
        return cell
    }
}

// MARK: - Protocols for load Image from gallery
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func openProfile() {
        print("profile is opened")
    }
}

// MARK: - Extension for setup elements
private extension ProfileViewController {
    
    var _scrollView: UIScrollView {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }
    
    var _contentView: UIView {
        let view = UIView()
        return view
    }
    
    var _profileTitle: UILabel {
        let label = UILabel()
        label.text = "My profile"
        label.font = UIFont.poppinsSemiBold(size: 24)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }

    var _profileImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileImage")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }
    
    var _recipesTitle: UILabel {
        let label = UILabel()
        label.text = "My recipes"
        label.font = UIFont.poppinsSemiBold(size: 24)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }
    
    var _collectionView: UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.cellID)
        collectionView.isScrollEnabled = false
        return collectionView
    }
}
