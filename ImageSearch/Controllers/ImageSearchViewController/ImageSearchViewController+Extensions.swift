//
//  ImageSearchViewController+Extensions.swift
//  ImageSearch
//
//  Created by Romain RABOUAN on 06/07/2022.
//

import UIKit

extension ImageSearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text else {
            return false
        }
        
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
        submitButton.isEnabled = !newText.isEmpty
        
        return true
    }
}
