//
//  UILabel + Extension.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import UIKit

extension UILabel {
    
    func addTrailing(image: UIImage?) {
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let imageString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: self.text!, attributes: [:])
        
        string.append(imageString)
        self.attributedText = string
    }
    
    func addLeading(image: UIImage?) {
        let string = NSMutableAttributedString(string: self.text!)
        
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let imageString = NSAttributedString(attachment: attachment)
        
        string.append(imageString)
        string.append(NSAttributedString(string: self.text!))
        
        self.attributedText = string
    }
}
