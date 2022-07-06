//
//  ResultsViewController.swift
//  ImageSearch
//
//  Created by Romain RABOUAN on 06/07/2022.
//

import UIKit

class ResultsViewController: UICollectionViewController {
    
    // Choses the mode (Selection or normal)
    enum Mode {
        case normal
        case select
    }
    
    var queryText: String?
    
    let cellId = "cell"
    
    let imageSearchAPI = ImageSearchAPI.shared
    var imagesURL: [String] = []
    var selectedItems: [String] = []
    
    var mode: Mode = .normal {
        didSet {
            switch mode {
            case .normal:
                selectBarButtonItem.title = "Select"
                navigationItem.leftBarButtonItem = nil
                collectionView.allowsMultipleSelection = false
            case .select:
                selectBarButtonItem.title = "Show images"
                navigationItem.leftBarButtonItem = cancelBarButtonItem
                collectionView.allowsSelection = true
                collectionView.allowsMultipleSelection = true
            }
        }
    }
    
    lazy var selectBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selectButtonClicked))
        return item
    }()
    
    lazy var cancelBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonClicked))
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.allowsSelection = false
                
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = selectBarButtonItem
        
        title = "Results"
        
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        Task {
            await self.fetchImages()
            self.collectionView.reloadData()
        }
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
            DispatchQueue.main.async {
                cell.resultImageView.loadImage(url)
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Il aurait été largement mieux de passer les images plutôt que les URL, évitant ainsi de devoir retélécharger l'image une nouvelle fois...
        selectedItems.append(imagesURL[indexPath.item])
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let element = selectedItems.firstIndex(of: imagesURL[indexPath.item]) {
            selectedItems.remove(at: element)
        }
    }
    
    /// Handle the "Select" button action.
    @objc
    func selectButtonClicked() {
        switch mode {
        case .normal:
            self.mode = .select
        case .select:
            
            // We want to show the images only if the selected images is greater than 0
            guard selectedItems.count > 0 else {
                return
            }
            
            let detailCollectionView = DetailCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
            detailCollectionView.selectedImages = selectedItems
            self.navigationController?.pushViewController(detailCollectionView, animated: true)
        }
    }
    
    /// Cancel the selection
    @objc
    func cancelButtonClicked() {
        self.mode = .normal
    }
    
    /// Fetch the images from the service.
    private func fetchImages() async {
        guard let queryText = queryText else {
            return
        }
        
        Task {
            if let urls = await imageSearchAPI.getImagesFromServer(with: queryText) {
                // Update the UI when the image urls are fetched.
                DispatchQueue.main.async { [weak self] in
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
}
