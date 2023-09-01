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
        return imageViewBackground
    }()
    
    private lazy var startButton: UIButton = {
        let startButton = UIButton()
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return startButton
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
    }
    
    // MARK: - Layout
    private func setupLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
