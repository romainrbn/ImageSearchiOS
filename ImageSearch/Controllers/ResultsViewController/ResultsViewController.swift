//
//  ResultsViewController.swift
//  ImageSearch
//
//  Created by Romain RABOUAN on 06/07/2022.
//

import UIKit

class ResultsViewController: UICollectionViewController {
    
    var queryText: String?
    
    let cellId = "cell"
    
    let imageSearchAPI = ImageSearchAPI.shared
    
    var imagesURL: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Results"
        
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        self.fetchImages()
    }
    
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesURL.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ResultCollectionViewCell
        
        if let url = URL(string: imagesURL[indexPath.item]) {
            DispatchQueue.main.async { [weak self] in
                cell.resultImageView.loadImage(url)
                self?.collectionView.reloadData()
            }
        }
        return cell
    }
    
    // Show the detail view
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    /// Fetch the images from the service.
    private func fetchImages() {
        guard let queryText = queryText else {
            return
        }
        
        Task {
            if let urls = await imageSearchAPI.getImagesFromServer(with: queryText) {
                // Update the UI when the image urls are fetched.
                DispatchQueue.main.async { [weak self] in
                    print("URLs fetched!: \(urls)")
                    self?.imagesURL = urls
                    self?.collectionView.reloadData()
                }
            } else {
                // For larger projects, we could create an error enum, with a localized description for each type of error.
                DispatchQueue.main.async { [weak self] in
                    self?.createAlert(title: "Error",
                                     message: "Could not proceed with the request. Check your internet connection and try again.")
                }
            }
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}