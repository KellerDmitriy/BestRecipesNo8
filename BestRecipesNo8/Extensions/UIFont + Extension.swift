//
//  UIFont + Extension.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 27.08.2023.
//

import UIKit

extension UIFont {
    
    class var bolt56: UIFont {
        return UIFont(name: "Poppins", size: 56) ??  UIFont.systemFont(ofSize: 56, weight: .bold)
    }
    
    class var bold48: UIFont {
        return UIFont(name: "Poppins", size: 48) ??  UIFont.systemFont(ofSize: 48, weight: .bold)
    }
    
    class var bold40: UIFont {
        return UIFont(name: "Poppins", size: 40) ??  UIFont.systemFont(ofSize: 40, weight: .bold)
    }
    
    class var bold32: UIFont {
        return UIFont(name: "Poppins", size: 32) ??  UIFont.systemFont(ofSize: 32, weight: .bold)
    }
    
    class var bold24: UIFont {
        return UIFont(name: "Poppins", size: 24) ??  UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    class var bold16: UIFont {
        return UIFont(name: "Poppins", size: 16) ??  UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    class var regular16: UIFont {
        return UIFont(name: "Poppins", size: 16) ??  UIFont.systemFont(ofSize: 16, weight: .regular)
    }

}
