//
//  CustomNavigationController.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 30.08.23.
//

import UIKit

extension UINavigationController {
    
    func setupNavigationBar() {
        navigationBar.barTintColor = .neutralColor10
        
        let backButtonImage = UIImage(systemName: "arrow.left")
        let alignInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        navigationBar.backIndicatorImage = backButtonImage?.withAlignmentRectInsets(alignInsets)
        navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigationBar.tintColor = .black
        navigationBar.topItem?.title = ""

        let moreButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(moreButtonTapped))
        moreButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        topViewController?.navigationItem.rightBarButtonItem = moreButton
    }
    
    @objc private func moreButtonTapped() {}
}


