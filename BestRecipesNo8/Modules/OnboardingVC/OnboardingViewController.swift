//
//  OnboardingViewController.swift
//  BestRecipesNo8
//
//  Created by Admin on 05.09.2023.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let router = RouterProtocol.self
    // MARK: - Properties
    
    lazy var nextButton: CustomButton = {
        let startButton = CustomButton(customTitle: "Continue")
        startButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return startButton
    }()
    
    lazy var skipButton: UIButton = {
        let element = UIButton()
        element.setTitle("Skip", for: .normal)
        element.titleLabel?.font = .poppinsRegular(size: 13)
        element.titleLabel?.textColor = .white
        element.addTarget(self, action: #selector(pushViewController), for: .touchUpInside)
        return element
    }()
    
    lazy var onboardingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.contentSize = CGSize(
            width: Double(Int(view.bounds.width) * background.count),
            height: Double(view.bounds.height)
        )
        return scrollView
    }()
    
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.preferredIndicatorImage = UIImage(named: "RectangleSelect")
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .primaryColor
        pageControl.addTarget(self, action: #selector(nextPage), for: .valueChanged)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    lazy var onboardingImageViewArray: [UIImageView] = {
        var array: [UIImageView] = []
        for i in 0..<background.count {
            let imageView = UIImageView(image: background[i])
            imageView.contentMode = .scaleAspectFill
            array.append(imageView)
        }
        return array
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        let string = NSMutableAttributedString(string: "Recipes from all over the World")
        string.setColorForText("over the World", with: .threeRDColor)
        label.attributedText = string
        label.textColor = .whiteColor
        label.font = .poppinsBold(size: 40)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var background = [
        UIImage(named: "OnboardingPage1"),
        UIImage(named: "OnboardingPage2"),
        UIImage(named: "OnboardingPage3")
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        
        let tabBarC = self.tabBarController?.tabBar
        tabBarC?.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onboardingScrollViewsAddSubviews()
    }
    
    //MARK: - Private Methods
    private func onboardingScrollViewsAddSubviews() {
        for i in 0..<onboardingImageViewArray.count {
            onboardingScrollView.addSubview(onboardingImageViewArray[i])
            onboardingImageViewArray[i].frame = CGRect(x: view.bounds.width * CGFloat(i), y: 0, width: view.bounds.width, height: view.bounds.height)
        }
    }
    
    @objc private func pageControlDidChange() {
        let offsetX = view.bounds.width * CGFloat(pageControl.currentPage)
        onboardingScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @objc private func nextPage() {
        let offsetX = view.bounds.width * CGFloat(pageControl.currentPage + 1)
        onboardingScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @objc private func pushViewController() {
        let assemblyBuilder = AssemblyBuilder()
        let navigationController = UINavigationController()
        let router = Router(assemblyBuilder: assemblyBuilder, navigationController: navigationController)
        let tabbarVC = CustomTabBarController(assemblyBuilder: assemblyBuilder, router: router)
        UserDefaults.standard.set(false, forKey: "showOnboarding")
        navigationController.setViewControllers([tabbarVC], animated: true)
        navigationController.navigationBar.isHidden = true
    }
    
    // MARK: - Hierarchy
    
    private func setupHierarchy() {
        addSubViews()
        makeConstraints()
    }
}
//MARK: - UIScrollViewDelegate

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0
        pageControl.currentPage = Int(onboardingScrollView.contentOffset.x / view.bounds.width)
        
        switch pageControl.currentPage {
        case 0:
            let string = NSMutableAttributedString(string: "Recipes from all over the World")
            string.setColorForText("over the World", with: .threeRDColor)
            skipButton.isHidden = false
            nextButton.setTitle("Continue", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            titleLabel.attributedText = string
            
        case 1:
            let string = NSMutableAttributedString(string: "Recipes with each and every detail")
            string.setColorForText("each and every detail", with: .threeRDColor)
            skipButton.isHidden = false
            nextButton.setTitle("Continue", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            titleLabel.attributedText = string
            
        default:
            let string = NSMutableAttributedString(string: "Cook it now or save it for later")
            string.setColorForText("save it for later", with: .threeRDColor)
            skipButton.isHidden = true
            nextButton.setTitle("Start Cooking", for: .normal)
            nextButton.addTarget(self, action: #selector(pushViewController), for: .touchUpInside)
            titleLabel.attributedText = string
        }
    }
}

//MARK: - Layout
extension OnboardingViewController {
    
    private func addSubViews() {
        let views: [UIView] = [onboardingScrollView, nextButton, pageControl, titleLabel, skipButton]
        views.forEach { self.view.addSubview($0) }
    }
    
    private func makeConstraints() {
        onboardingScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-34)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(40)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-40)
            make.height.equalTo(46)
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(pageControl.snp.top).offset(-10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(53)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-74)
        }
    }
}
