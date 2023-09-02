//
//  UIView + Extension.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 1.09.23.
//

import UIKit

extension UIView {
    
    func addBottomShadow() {
        let shadowLayer = CALayer()
        shadowLayer.frame = bounds
        shadowLayer.cornerRadius = layer.cornerRadius
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.fillColor = UIColor.darkGray.cgColor
        maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        shadowLayer.mask = maskLayer
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.darkGray.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        shadowLayer.addSublayer(gradientLayer)
        
        layer.addSublayer(shadowLayer)
    }
    
    func makeCircular() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
}

