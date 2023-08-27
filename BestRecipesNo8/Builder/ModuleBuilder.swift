//
//  ModuleBuilder.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 27.08.2023.
//

import UIKit

protocol ModuleBuilderProtocol: AnyObject {
    
    func createStartScreenModule(router: RouterProtocol) -> UIViewController
    
}
