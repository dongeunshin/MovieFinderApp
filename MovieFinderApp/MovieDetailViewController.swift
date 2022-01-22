//
//  MovieDetailViewController.swift
//  MovieFinderApp
//
//  Created by dong eun shin on 2022/01/16.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    let titleLabel = UILabel()
    
    
    var indexpath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
    }
    
    func uiSetup(){
        titleLabel.text = "Title"
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        
        let safeArea = view.safeAreaLayoutGuide
        
        titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true

    }
}
