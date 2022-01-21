//
//  HomeViewController.swift
//  MovieFinderApp
//
//  Created by dong eun shin on 2022/01/16.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
           
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
                
        collectionViewConstraints()
        
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBtnPressed(_:)))
        self.navigationItem.rightBarButtonItem = searchBtn
        
        let quaryValue = "Ironman"
        dataManager.shared.fetch(queryValue: quaryValue) {
            self.collectionView.reloadData()
            print("reload in Home")
        }
        
    }
    
    private func collectionViewConstraints(){
        view.addSubview(collectionView)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    @objc private func searchBtnPressed(_ sender: Any) {
        let vc = SearchBarViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.indexpath = indexPath
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.shared.movieList.count
    }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
      
      let target = dataManager.shared.movieList[indexPath.row]
      
      if let imageURL = URL(string: target.image) {
          cell.imageView.kf.setImage(with: imageURL)
      }
      cell.titleLabel.text = target.title
      cell.ratingLabel.text = target.userRating
    
      return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let cellWidth = 150
    let cellHeight = 250
    return CGSize(width: cellWidth, height: cellHeight)
  }
}

