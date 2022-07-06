//
//  ViewController.swift
//  ImageSearch
//
//  Created by Romain RABOUAN on 06/07/2022.
//

import UIKit

class ImageSearchViewController: UIViewController {
    
    lazy var searchField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search for images..."
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(submitQuery), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search images 🔍"
        
        // Register for keyboard notifications, to move the view accordingly
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        self.configureView()
    }
    
    /// Configures the UI layout.
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchField)
        view.addSubview(submitButton)
        
        searchField.delegate = self
        
        configureConstraints()
    }
    
    /// Creates AutoLayout constraints for the subviews
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            // Constraints for the search field.
            searchField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            searchField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            searchField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            
            // Constraints for the submit button.
            submitButton.topAnchor.constraint(equalTo: self.searchField.bottomAnchor, constant: 15),
            submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    /// Submits the query and passes the data to the ResultsViewController
    @objc
    func submitQuery() {
        guard let queryText = searchField.text else {
            return
        }
        let resultsViewController = ResultsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        resultsViewController.queryText = queryText
        self.navigationController?.pushViewController(resultsViewController, animated: true)
    }
}
