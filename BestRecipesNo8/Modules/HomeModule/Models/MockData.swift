//
//  MockData.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import UIKit

struct MockData {
    
    static let shared = MockData()
    
    private let trendingNow: ListSection = {
        .trendingNow([.init(title: "sharwama", image: UIImage(named: "trendingImage1"), rating: 4.5),
                      .init(title: "sandwich", image: UIImage(named: "trendingImage2"), rating: 4.8),
                      .init(title: "dinner", image: UIImage(named: "trendingImage1"), rating: 5.0),
        ])
    }()
    
    private let popularCategories: ListSection = {
        .popularCategories([.init(title: "Salad", image: nil),
                            .init(title: "Breakfast", image: nil),
                            .init(title: "Appetizer", image: nil),
                            .init(title: "Noodle", image: nil),
                            .init(title: "Lunch", image: nil)
        ])
    }()
    
    private let popularRecipes: ListSection = {
        .popularRecipe([.init(title: "Chicken and Vegetable wrap", image: UIImage(named: "popularImage1"), time: 5),
                        .init(title: "Chicken and Vegetable wrap", image: UIImage(named: "popularImage2"), time: 10),
                        .init(title: "Chicken and Vegetable wrap", image: UIImage(named: "popularImage1"), time: 25)
        ])
    }()
    
    private let recentRecipe: ListSection = {
        .recentRecipe([.init(title: "Kelewele Ghanian Recipe", image: UIImage(named: "recentImage1")),
                       .init(title: "Kelewele Ghanian Recipe", image: UIImage(named: "recentImage2")),
                       .init(title: "Kelewele Ghanian Recipe", image: UIImage(named: "recentImage3"))
        ])
    }()
    
    private let teamMembers: ListSection = {
        .teamMembers([.init(title: "Kitty 1", image: UIImage(named: "member1")),
                      .init(title: "Kitty 2", image: UIImage(named: "member2")),
                      .init(title: "Kitty 3", image: UIImage(named: "member3")),
                      .init(title: "Kitty 4", image: UIImage(named: "member4")),
                      .init(title: "Kitty 5", image: UIImage(named: "member5"))
        ])
    }()
    
    var pageData: [ListSection] {
        [trendingNow, popularCategories, popularRecipes, recentRecipe, teamMembers]
    }
}
