//
//  OnboardingViewController.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 27.08.2023.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    // MARK: - Properties
    
    lazy var nextButton: CustomButton = {
        let startButton = CustomButton(customTitle: "Get Started")
        startButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return startButton
    }()
    
    lazy var onboardingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.contentSize = CGSize(
            width: Double(Int(view.bounds.width) * background.count),
            height: 400
        )
        return scrollView
    }()
    
    
    lazy var onboardingPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = background.count
        //        pageControl.currentPageIndicatorTintColor = .primaryColor
        //        pageControl.pageIndicatorTintColor = .neutralColor
        
        let selectedImage = UIImage(systemName: "RectangleSelect")
        
        let deselectedImage = UIImage(systemName: "Rectangle")
        
        pageControl.setIndicatorImage(selectedImage, forPage: pageControl.currentPage)
        pageControl.setIndicatorImage(deselectedImage, forPage: pageControl.currentPage + 1)
        pageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
        pageControl.allowsContinuousInteraction = true
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
        label.text = OnboardingConstants.Title.first.getTitle
        label.textColor = .whiteColor
        label.font = .poppinsBold(size: 52)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var subtitle1: UILabel = {
        let label = UILabel()
        label.text = OnboardingConstants.Subtitle1.first.getTitle
        label.textColor = .whiteColor
        label.font = .poppinsBold(size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var background = [
        OnboardingConstants.Image.first.getImage,
        OnboardingConstants.Image.second.getImage,
        OnboardingConstants.Image.third.getImage
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        
        let tabBarC = self.tabBarController?.tabBar
        tabBarC?.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Private Methods
    private func onboardingScrollViewsAddSubviews() {
        for i in 0..<onboardingImageViewArray.count {
            onboardingScrollView.addSubview(onboardingImageViewArray[i])
            onboardingImageViewArray[i].frame = CGRect(x: Int(view.bounds.width) * i, y: 0, width: Int(view.bounds.width), height: Int(view.bounds.height))
        }
    }
    
    @objc private func pageControlDidChange() {
        let offsetX = view.bounds.width * CGFloat(onboardingPageControl.currentPage)
        onboardingScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @objc private func nextPage() {
        let offsetX = view.bounds.width * CGFloat(onboardingPageControl.currentPage + 1)
        onboardingScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @objc private func pushViewController() {
        //        defaults.set("ok", forKey: "onbording")
        //        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
        //            sceneDelegate.checkAuthentication()
        //        }
        //        navigationController?.pushViewController( Builder.getSignInModule(), animated: true)
    }
    
    // MARK: - Hierarchy
    
    private func setupHierarchy() {
        addSubViews()
        makeConstraints()
        onboardingScrollViewsAddSubviews()
    }
}
//MARK: - UIScrollViewDelegate

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onboardingPageControl.currentPage = Int(onboardingScrollView.contentOffset.x / view.bounds.width)
        
        switch onboardingPageControl.currentPage {
        case 0:
            nextButton.setTitle("Continue", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            subtitle1.text = OnboardingConstants.Subtitle1.first.getTitle
            titleLabel.text = OnboardingConstants.Title.first.getTitle
            
        case 1:
            nextButton.setTitle("Continue", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            subtitle1.text = OnboardingConstants.Subtitle1.second.getTitle
            titleLabel.text = OnboardingConstants.Title.second.getTitle
            
        default:
            subtitle1.text = OnboardingConstants.Subtitle1.first.getTitle
            titleLabel.text = OnboardingConstants.Title.first.getTitle
        }
    }
}

//MARK: - Layout
extension OnboardingViewController {
    
    private func addSubViews() {
        let views: [UIView] = [onboardingScrollView, nextButton, onboardingPageControl, titleLabel, subtitle1]
        views.forEach { self.view.addSubview($0) }
    }
    
    private func makeConstraints() {
        onboardingScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        onboardingPageControl.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-34)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(40)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-40)
            make.height.equalTo(46)
        }
        
        subtitle1.snp.makeConstraints { make in
            make.bottom.equalTo(onboardingPageControl.snp.top).offset(-173)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(40)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-52)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subtitle1.snp.top).offset(-10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(53)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-74)
        }
    }
}

