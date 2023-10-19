//
//  CustomTabBarController.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 31.08.23.
//

import UIKit

final class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Views
    private lazy var backgroundShadowImageView: UIImageView = _backgroundShadowImageView
    private lazy var backgroundImageView: UIImageView = _backgroundImageView

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        view.backgroundColor = .white
        setupSubviews()
        applyConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        if !UserDefaults().bool(forKey: "showOnboarding") {
            let startViewController = StartViewController()
            let navigationController = UINavigationController(rootViewController: startViewController)
            startViewController.modalPresentationStyle = .automatic
            startViewController.modalTransitionStyle = .coverVertical
            self.present(navigationController, animated: true)
        }
    }
    
    //MARK: - Public methods
    func navigationControllers(_ controllers: UIViewController...) {
        self.viewControllers = controllers
    }
    

    // MARK: - Subviews
    private func setupSubviews() {
        tabBar.addSubview(backgroundImageView)
        tabBar.addSubview(backgroundShadowImageView)
        tabBar.sendSubviewToBack(backgroundShadowImageView)
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
}
