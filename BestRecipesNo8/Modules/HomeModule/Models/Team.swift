//
//  Team.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 24.10.2023.
//

import UIKit

struct Team {
    let title: String
    let image: UIImage?
    init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    static let teamMembersData: [Team] = [
        .init(title: "Kitty 1", image: UIImage(named: "member1")),
        .init(title: "Kitty 2", image: UIImage(named: "member2")),
        .init(title: "Kitty 3", image: UIImage(named: "member3")),
        .init(title: "Kitty 4", image: UIImage(named: "member4")),
        .init(title: "Kitty 5", image: UIImage(named: "member5"))
    ]
    
}
