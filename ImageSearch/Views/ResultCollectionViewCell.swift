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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        NSLayoutConstraint.activate([
            resultImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            resultImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            resultImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            resultImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
