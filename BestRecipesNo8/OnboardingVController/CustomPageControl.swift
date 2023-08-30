//
//  CustomPageControl.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 29.08.2023.
//

import UIKit

class CustomPageControlViewController: UIViewController {
    private let pageControl = UIPageControl()
    private let customIndicatorViews: [UIView] = {
        // Create custom indicator views here, one for each page
        // For example, you can create UIImageViews with custom images
        let imageNames = ["RectangleSelect", "Rectangle"]
        return imageNames.map { imageName in
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleAspectFit
            return imageView
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the custom indicator views as subviews
        customIndicatorViews.forEach { indicatorView in
            view.addSubview(indicatorView)
        }
        
        // Configure the UIPageControl
        pageControl.numberOfPages = customIndicatorViews.count
        pageControl.currentPageIndicatorTintColor = .systemGreen
        pageControl.pageIndicatorTintColor = .systemRed
        pageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Position the custom indicator views
        let indicatorSize = CGSize(width: 20, height: 20)
        let indicatorSpacing: CGFloat = 10
        let totalWidth = CGFloat(customIndicatorViews.count) * indicatorSize.width + CGFloat(customIndicatorViews.count - 1) * indicatorSpacing
        let startX = (view.bounds.width - totalWidth) / 2
        let startY: CGFloat = 300
        
        for (index, indicatorView) in customIndicatorViews.enumerated() {
            let x = startX + CGFloat(index) * (indicatorSize.width + indicatorSpacing)
            indicatorView.frame = CGRect(x: x, y: startY, width: indicatorSize.width, height: indicatorSize.height)
        }
    }
    
    @objc private func pageControlDidChange() {
        // Handle page control value change event
    }
    
    // Other methods and properties...
}
