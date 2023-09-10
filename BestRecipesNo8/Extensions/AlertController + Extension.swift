//
//  AlertController + Extension.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 10.09.2023.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, completion: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let newValue = alert.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
            completion(newValue)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = "Enter information"
            textField.keyboardType = .numberPad
        }
        
        present(alert, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
