//
//  OnboardingViewController.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 27.08.2023.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    private lazy var backgroundView: UIImageView = {
        let imageViewBackground = UIImageView(frame: UIScreen.main.bounds)
        imageViewBackground.image = UIImage(named: "OnbordingImg1")
        return imageViewBackground
    }()
    
//    private lazy var getStartedButton: CustomButton = {
//        let getStartedButton = CustomButton(customTitle: "Get Started")
//        getStartedButton.addTarget(self, action: #selector(getStartedButtonPressed), for: .touchUpInside)
//        return getStartedButton
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }
    
    @objc private func getStartedButtonPressed() {
        
    }
    
    private func setupHierarchy() {
        view.addSubview(backgroundView)
       // view.addSubview(getStartedButton)
    }
    
    private func setupLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        getStartedButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.bottom.equalToSuperview().inset(82)
//            make.width.equalTo(156)
//            make.height.equalTo(56)
//
//        }
    }
    
}
