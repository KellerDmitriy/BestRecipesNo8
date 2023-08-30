//
//  OnboardingConstants.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 29.08.2023.
//

import UIKit

enum OnboardingConstants {
    enum Image {
        case first
        case second
        case third
        
        var getImage: UIImage {
            switch self {
            case .first:
                return UIImage(named: "2") ?? UIImage()
            case .second:
                return UIImage(named: "3") ?? UIImage()
            case .third:
                return UIImage(named: "4") ?? UIImage()
            }
        }
    }
    
    enum Title {
        case first
        case second
        case third
        case fourth
        
        var getTitle: String {
            switch self {
            case .first:
                return "Best Recipe"
            case .second:
                return "Recipes from all over the World"
            case .third:
                return "Recipes with each and every detail"
            case .fourth:
                return "Cook it now or save it for later"

            }
        }
    }
    
    enum Subtitle1 {
        case first
        case second
        case third
        case fourth

        var getTitle: String {
            switch self {
            case .first:
                return "Find best recipes for cooking"
            case .second:
                return ""
            case .third:
                return ""
            case .fourth:
                return ""
            }
        }
    }
    
    enum Subtitle2 {
        case first
        case second
        case third
        case fourth

        
        var getTitle: String {
            switch self {
            case .first:
                return "APP UI KIT"
            case .second:
                return "APP UI KIT"
            case .third:
                return "APP UI KIT"
            case .fourth:
                return "APP UI KIT"
            }
        }
    }
}
