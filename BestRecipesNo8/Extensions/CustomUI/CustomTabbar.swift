//
//  CustomTabBar.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 31.08.23.
//

import UIKit

final class CustomTabBar: UITabBarController {
    
    
    // MARK: - Views
    private lazy var backgroundShadowImageView: UIImageView = _backgroundShadowImageView
    private lazy var backgroundImageView: UIImageView = _backgroundImageView
    private lazy var createButton: UIButton = _createButton
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        view.backgroundColor = .white
        
        setupSubviews()
        applyConstraints()
        assignTabBarModules()
        
    }
    
    // MARK: - Create Button Method
    @objc private func createButtonIsTapped(_ sender: UIButton) {
        print("createButtonIsTapped")
        //let view = SeeAllBuilder.createSeeAllModule(
       // self.navigationController?.pushViewController(view, animated: true)
        
    }
    
    // MARK: - TabBarItem setup a controller and images
    private func assignTabBarModules() {
        let mainVC = MainScreenBuilder.createMainScreenViewController()
        let discoverVC = SavedRecipesBuilder.createSavedRecipesModule()
        let notificationVC = NotificationViewController()
        let profileVC = ProfileBuilder.createProfileModule()
        
        mainVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "main")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "mainSelect")?.withRenderingMode(.alwaysOriginal))
        
        discoverVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "bookmark")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bookmarkSelect")?.withRenderingMode(.alwaysOriginal))
        
        notificationVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "notification")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "notificationSelect")?.withRenderingMode(.alwaysOriginal))
        
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "profileSelect")?.withRenderingMode(.alwaysOriginal))
        
        setViewControllers([mainVC, discoverVC, notificationVC, profileVC], animated: true)
    }
    // MARK: - Subviews
    private func setupSubviews() {
        tabBar.addSubview(backgroundImageView)
        tabBar.addSubview(backgroundShadowImageView)
        tabBar.sendSubviewToBack(backgroundShadowImageView)
        view.addSubview(createButton)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        
        backgroundImageView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(106)
        }
        
        backgroundShadowImageView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(103)
        }
        
        createButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(67)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(48)
        }
    }
}

// MARK: - Extension for setup elements
private extension CustomTabBar {
    
    var _backgroundShadowImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage.backgroundShadow
        return imageView
    }
    
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
