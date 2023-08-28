//
//  SettingsManager.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 28.08.2023.
//

import Foundation

protocol SettingsManagerProtocol {
    func updateOnboarding()
}

class SettingsManager: SettingsManagerProtocol {
    let defaults = UserDefaults.standard
    
    func updateOnboarding() {
        // 
    }
}
