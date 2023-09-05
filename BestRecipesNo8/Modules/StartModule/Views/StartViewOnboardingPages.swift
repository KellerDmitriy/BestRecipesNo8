//
//  StartViewOnboardingPages.swift
//  BestRecipesNo8
//
//  Created by Daria Arisova on 05.09.2023.
//

import UIKit
import SnapKit

final class StartViewOnboardingPages: UIViewController {
    
    private let presenter: StartViewOutput
    
    private let pageBackgroundImage = {
        let view = UIImageView(frame: UIScreen.main.bounds)
        view.setGradientColor(topColor: .clear, bottomColor: .black)
        return view
    }()
    private let pageLabel: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular(size: 16)
        label.textColor = .whiteColor
        label.textAlignment = .center
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()
    private lazy var continueButton: UIButton = {
        let continueButton = UIButton()
        continueButton.titleLabel?.font = UIFont(name: "Inter", size: 20)
        continueButton.backgroundColor = .primaryColor
        continueButton.layer.cornerRadius = 23
        return continueButton
    }()
    private lazy var skipButton: UIButton = {
        let skipButton = UIButton()
        skipButton.setTitle("Skip", for: .normal)
        skipButton.titleLabel?.font = UIFont(name: "Inter", size: 10)
        skipButton.backgroundColor = .clear
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return skipButton
    }()
    
    // MARK: - Init
    init(presenter: StartViewOutput/*, onboarding: OnboardingHelper*/) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
//        let string = NSMutableAttributedString(string: onboarding.text)
//        string.setColorForText(onboarding.textToColor, with: UIColor.red)
//        pageBackgroundImage.image = onboarding.backgroundImage
//        pageLabel.attributedText = string
//        continueButton.setTitle(onboarding.continueBtnTitle, for: .normal)
        
//        todo какие-то проверки, чтобы избавиться от skipBtn
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }
    
    @objc private func skipButtonTapped() {
        presenter.skipButtonTapped()
    }
    
    // MARK: - Hierarchy
    private func setupHierarchy() {
        view.addSubview(pageBackgroundImage)
        view.addSubview(pageLabel)
        view.addSubview(continueButton)
        view.addSubview(skipButton)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        pageBackgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        skipButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(32)
        }
        
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
            make.width.equalTo(193)
            make.height.equalTo(44)
        }
    }
}

extension StartViewOnboardingPages: StartViewInput {
    func startApp() {
        print("done")
//        метод должен либо демонстрировать онбординг либо переходить на экран home
    }
}

