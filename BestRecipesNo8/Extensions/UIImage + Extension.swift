//
//  UIImage + Extension.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 30.08.2023.
//

import UIKit

extension UIImage {
    
    static func cropImage(image: UIImage, withScale scale: CGFloat = 0.8) -> UIImage? {
        
        let xOffset = (image.size.width - image.size.width * scale) / 2.0
        let yOffset = (image.size.height - image.size.height * scale) / 2.0
        
        let cropZone = CGRect(x: xOffset,
                              y: yOffset,
                              width: image.size.width * scale,
                              height: image.size.height * scale)
        
        guard let cutImageRef: CGImage = image.cgImage?.cropping(to: cropZone)
        else { return nil }
        
        let croppedImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
}
