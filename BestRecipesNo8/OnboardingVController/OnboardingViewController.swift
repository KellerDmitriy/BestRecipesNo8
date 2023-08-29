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
    
    //MARK: - UI
    
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
            height: 360
        )
        return scrollView
    }()
    
    
    lazy var onboardingPageControl: UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = 3
        page.currentPage = 0
        page.backgroundStyle = .minimal

        let selectedImage = UIImage(systemName: "RectangleSelect")?.withTintColor(page.currentPageIndicatorTintColor ?? .primaryColor, renderingMode: .alwaysTemplate)
        let deselectedImage = UIImage(systemName: "Rectangle")?.withTintColor(page.pageIndicatorTintColor ?? .threeRDColor, renderingMode: .alwaysTemplate)
        page.setIndicatorImage(selectedImage, forPage: page.currentPage)
        page.setIndicatorImage(deselectedImage, forPage: page.currentPage + 1)
        page.translatesAutoresizingMaskIntoConstraints = false
        page.isUserInteractionEnabled = true
        return page
    }()
    
    lazy var onboardingImageViewArray: [UIImageView] = {
        var array: [UIImageView] = []
        for i in 0..<background.count {
            let imageView = UIImageView(image: background[i])
            imageView.contentMode = .scaleToFill
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
        OnboardingConstants.Image.third.getImage,
        OnboardingConstants.Image.fourth.getImage
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        
        let tabBarC = self.tabBarController?.tabBar
        tabBarC?.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Target Actions
    
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
    
    //MARK: - Layout
    
    private func setConstraints() {
        addSubViews()
        makeConstraints()
        onboardingScrollViewsAddSubviews()
    }
    
    private func onboardingScrollViewsAddSubviews() {
        for i in 0..<onboardingImageViewArray.count {
            onboardingScrollView.addSubview(onboardingImageViewArray[i])
            onboardingImageViewArray[i].frame = CGRect(x: view.bounds.width * CGFloat(i), y: 0, width: view.bounds.width, height: view.bounds.height)
        }
    }
    }

//MARK: - UIScrollViewDelegate

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onboardingPageControl.currentPage = Int(onboardingScrollView.contentOffset.x / view.bounds.width)
        
        switch onboardingPageControl.currentPage {
        case 0:
            nextButton.setTitle("Get Started", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            subtitle1.text = OnboardingConstants.Subtitle1.first.getTitle
            titleLabel.text = OnboardingConstants.Title.first.getTitle
            
        case 1:
            nextButton.setTitle("Continue", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            subtitle1.text = OnboardingConstants.Subtitle1.second.getTitle
            titleLabel.text = OnboardingConstants.Title.second.getTitle
            
        case 2:
            subtitle1.text = OnboardingConstants.Subtitle1.third.getTitle
            titleLabel.text = OnboardingConstants.Title.third.getTitle
            nextButton.setTitle("Continue", for: .normal)
            nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            
        default:
            subtitle1.text = OnboardingConstants.Subtitle1.first.getTitle
            titleLabel.text = OnboardingConstants.Title.first.getTitle
        }
    }
}

//MARK: - UIScrollViewDelegate
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

