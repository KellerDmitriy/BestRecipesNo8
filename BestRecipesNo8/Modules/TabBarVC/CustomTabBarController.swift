//
//  CustomTabBarController.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 31.08.23.
//

import UIKit

final class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let assemblyBuilder: AssemblyBuilderProtocol
    let router: RouterProtocol

    init(assemblyBuilder: AssemblyBuilderProtocol, router: RouterProtocol) {
        self.assemblyBuilder = assemblyBuilder
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let view = assemblyBuilder.createCreateModule(router: router)
        navigationController?.setupNavigationBar()
        navigationController?.pushViewController(view, animated: true)
    }
    
    // MARK: - TabBarItem setup a controller and images
    private func assignTabBarModules() {
        let mainVC = UINavigationController(rootViewController: assemblyBuilder.createMainModule(router: router, searchController: assemblyBuilder))
        let SavedRecipe = UINavigationController(rootViewController: assemblyBuilder.createSavedRecipesModule(router: router))
        let notificationVC = UINavigationController(rootViewController: assemblyBuilder.createSearchModule(router: router))
        let profileVC = UINavigationController(rootViewController: assemblyBuilder.createProfileModule(router: router))
        
        mainVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "main")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "mainSelect")?.withRenderingMode(.alwaysOriginal))
        
        SavedRecipe.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "bookmark")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bookmarkSelect")?.withRenderingMode(.alwaysOriginal))
        
        notificationVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "notification")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "notificationSelect")?.withRenderingMode(.alwaysOriginal))
        
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "profileSelect")?.withRenderingMode(.alwaysOriginal))
        
        setViewControllers([mainVC, SavedRecipe, notificationVC, profileVC], animated: true)
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        let vc = UINavigationController(rootViewController: viewController)
        vc.tabBarItem.title = nil
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectedImage
        return vc
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
private extension CustomTabBarController {
    
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
