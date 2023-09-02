//
//  NotificationViewController.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 02.09.2023.
//

import UIKit

class NotificationViewController: UIViewController {
    private lazy var backgroundView: UIImageView = {
        let imageViewBackground = UIImageView(frame: UIScreen.main.bounds)
        imageViewBackground.image = UIImage(named: "Vladimir")
        imageViewBackground.contentMode = .scaleAspectFit
        return imageViewBackground
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }
    
    
    // MARK: - Hierarchy
    private func setupHierarchy() {
        view.addSubview(backgroundView)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
}
