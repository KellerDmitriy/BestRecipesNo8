//
//  ListItem.swift
//  BestRecipesNo8
//
//  Created by Мявкo on 6.09.23.
//

import UIKit

struct ListItem {
    let title: String
    let image: UIImage?
    let rating: Double?
    let time: Double?

    init(title: String, image: UIImage?, rating: Double? = nil, time: Double? = nil) {
        self.title = title
        self.image = image
        self.rating = rating
        self.time = time
    }
}
