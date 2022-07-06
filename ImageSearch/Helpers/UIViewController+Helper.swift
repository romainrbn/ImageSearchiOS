//
//  UIViewController+Helper.swift
//  ImageSearch
//
//  Created by Romain RABOUAN on 06/07/2022.
//

import UIKit

extension UIViewController {
    
    /// Creates a simple alert with a title and a message
    /// - Parameter title: The alert title
    /// - Parameter message: The alert message
    func createAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alertController, animated: true)
    }
}
