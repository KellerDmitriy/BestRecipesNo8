//
//  StartView.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.08.2023.
//

import UIKit
import SnapKit

final class StartView: UIViewController {
    
    private let presenter: StartViewOutput
    
    private lazy var backgroundView: UIImageView = {
        let imageViewBackground = UIImageView(frame: UIScreen.main.bounds)
        imageViewBackground.image = UIImage(named: "OnbordingImg1")
        imageViewBackground.setGradientColor(topColor: .clear, bottomColor: .black)
        return imageViewBackground
    }()
    
    private lazy var startButton: UIButton = {
        let startButton = UIButton()
        startButton.setTitle("Get Started", for: .normal)
        startButton.backgroundColor = .primaryColor
        startButton.layer.cornerRadius = 56/4
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return startButton
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Best Recipes"
        titleLabel.font = .poppinsBold(size: 56)
        titleLabel.textColor = .whiteColor
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.sizeToFit()
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Find best recipes for cooking"
        descriptionLabel.font = .poppinsRegular(size: 16)
        descriptionLabel.textColor = .whiteColor
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 1
        descriptionLabel.sizeToFit()
        return descriptionLabel
    }()
    // MARK: - Init
    
    init(presenter: StartViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
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
    
    // MARK: - Add Buttons Methods
    @objc private func startButtonTapped() {
        presenter.startButtonTapped()
    }
    
    // MARK: - Hierarchy
    private func setupHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(startButton)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(207)
            make.width.equalTo(320)
            make.height.equalTo(170)
        
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.width.equalTo(320)
            make.height.equalTo(20)
        }
        
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(82)
            make.width.equalTo(156)
            make.height.equalTo(56)
        }
    }
}

extension StartView: StartViewInput{
    func startApp() {
        print("done")
//        метод должен либо демонстрировать онбординг либо переходить на экран home
    }
}

extension UIView {
    func setGradientColor(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
}
