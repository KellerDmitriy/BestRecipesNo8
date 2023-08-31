//
//  TabBarView.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 31.08.23.
//

import UIKit

class TabBarView: UITabBarController {
    
    private let presenter: TabBarPresenter
    private let model = TabBarModel.views
    
    // MARK: - Views
    private lazy var backgroundImageView: UIImageView = _backgroundImageView
    private lazy var createButton: UIButton = _createButton
    
    // MARK: - Init
    init(presenter: TabBarPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        view.backgroundColor = .white

        setupSubviews()
        applyConstraints()
        assignTabBarModules()
    }
    
    // MARK: - For each TabBarItem setup a controller and images
    private func assignTabBarModules() {
        viewControllers = model.map { item in
            let controller = item.controller
            let image = item.tabBarImage?.withRenderingMode(.alwaysOriginal)
            let selectedImage = item.tabBarSelectedImage?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem = UITabBarItem(title: "", image: image, selectedImage: selectedImage)
            return controller
        }
    }
    
    // MARK: - Create Button Method
    @objc private func createButtonIsTapped(_ sender: UIButton) {
        print("Create button is tapped")
    }
    
    // MARK: - Subviews
    private func setupSubviews() {
        tabBar.addSubview(backgroundImageView)
        tabBar.sendSubviewToBack(backgroundImageView)
        view.addSubview(createButton)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(106)
        }
        
        createButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(67)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(48)
        }
    }
}

// MARK: - Extension for setup elements
private extension TabBarView {
    
    var _backgroundImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage.background
        return imageView
    }
    var _createButton: UIButton {
        let button = UIButton()
        button.setImage(UIImage.add, for: .normal)
        button.addTarget(self, action: #selector(createButtonIsTapped), for: .touchUpInside)
        return button
    }
}
