//
//  SeeAllPresenter.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import Foundation

final class SeeAllPresenter {
    weak var view: SeeAllViewInput?
    private let router: SeeAllRouterInput
   // private let settingsManager: SettingsManagerProtocol

    init(router: SeeAllRouterInput) {
        
        self.router = router 
        //self.settingsManager = settingsManager
    }
}

extension SeeAllPresenter: SeeAllViewOutput {
    func fetchData(for category: String) {
        //
    }
    

}
