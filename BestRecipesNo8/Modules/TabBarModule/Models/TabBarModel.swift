//
//  TabBarModel.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 31.08.23.
//

import UIKit

struct TabBarModel {
    let controller: UIViewController
    let tabBarImage: UIImage?
    let tabBarSelectedImage: UIImage?
    
    static let views = [
        TabBarModel(controller:  UIViewController(), tabBarImage: UIImage.main, tabBarSelectedImage: UIImage.mainSelect),
        TabBarModel(controller: UIViewController(), tabBarImage: UIImage.bookmark, tabBarSelectedImage: UIImage.bookmarkSelect),
        TabBarModel(controller: UIViewController(), tabBarImage: UIImage(), tabBarSelectedImage: UIImage()),
        TabBarModel(controller: UIViewController(), tabBarImage: UIImage.notification, tabBarSelectedImage: UIImage.notificationSelect),
        TabBarModel(controller: UIViewController(), tabBarImage: UIImage.profile, tabBarSelectedImage: UIImage.profileSelect)
    ]
}
