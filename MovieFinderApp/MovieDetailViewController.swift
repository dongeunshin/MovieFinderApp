//
//  MovieDetailViewController.swift
//  MovieFinderApp
//
//  Created by dong eun shin on 2022/01/16.
//

import UIKit
import WebKit

class MovieDetailViewController: UIViewController {
    
    var wkWebView: WKWebView? = nil
    var indexpath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let target = dataManager.shared.movieList[indexpath!.row]
//        let url = URL(string: target.link)
//
//        wkWebView?.translatesAutoresizingMaskIntoConstraints = false
//        let safeArea = view.safeAreaLayoutGuide
//        wkWebView?.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
//        wkWebView?.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true
//        wkWebView?.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0).isActive = true
//        wkWebView?.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0).isActive = true
//
//        let request = URLRequest(url: url!)
//
//        self.wkWebView?.load(request)
//        self.view.addSubview(self.wkWebView!)
        
        
//        let urlString = target.link
//        if let url = URL(string: urlString) {
//            let svc = SFSafariViewController(url: url)
//            self.present(svc, animated: true, completion: nil)
//        }
    
    }
}
