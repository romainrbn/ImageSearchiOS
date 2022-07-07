//
//  DetailCollectionViewController.swift
//  ImageSearch
//
//  Created by Romain RABOUAN on 06/07/2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class DetailCollectionViewController: UICollectionViewController {
    
    var selectedImages: [UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.allowsSelection = false
        
        self.collectionView!.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let selectedImages = selectedImages {
            return selectedImages.count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let selectedImages = selectedImages else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ResultCollectionViewCell
    
        let image = selectedImages[indexPath.item]
        
        cell.resultImageView.setImage(image)
    
        return cell
    }
}

extension DetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 15, left: 15, bottom: 15, right: 15)
    }
}

