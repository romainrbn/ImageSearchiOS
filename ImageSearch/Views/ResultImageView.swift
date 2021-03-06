//
//  ResultImageView.swift
//  ImageSearch
//
//  Created by Romain RABOUAN on 06/07/2022.
//

import UIKit

class ResultImageView: UIImageView {
    func loadImage(_ url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }
    
    // J'ai prévu une fonction (inutilisée ici) permettant de simplement charger une image dans l'ImageView
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}
