//
//  ResultCollectionViewCell.swift
//  ImageSearch
//
//  Created by Romain RABOUAN on 06/07/2022.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    lazy var resultImageView: ResultImageView = {
        let imageView = ResultImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var selectedIndicator: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle"))
        imageView.frame = .init(x: 0, y: 0, width: 30, height: 30)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            selectedIndicator.isHidden = !isSelected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.selectedIndicator.isHidden = true
        
        self.setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resultImageView.image = nil
    }
    
    /// Setup the views in the collection view cell.
    private func setupViews() {
        backgroundColor = UIColor.gray
        
        addSubview(resultImageView)
        addSubview(selectedIndicator)
        
        NSLayoutConstraint.activate([
            resultImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            resultImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            resultImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            resultImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            
            selectedIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            selectedIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
