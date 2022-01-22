//
//  MovieTableViewCell.swift
//  MovieFinderApp
//
//  Created by dong eun shin on 2022/01/17.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieTableViewCell"
    
    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let actorLabel: UILabel = {
        let personAge = UILabel()
        personAge.translatesAutoresizingMaskIntoConstraints = false
        return personAge
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        setConstraints()
    }
    
    private func addContentView() {
        contentView.addSubview(movieImage)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(actorLabel)
    }
    
    private func setConstraints() {
        let margin: CGFloat = 10
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: self.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImage.widthAnchor.constraint(equalToConstant: 100),
            movieImage.heightAnchor.constraint(equalToConstant: 100),
            
            movieNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            movieNameLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: margin),
            movieNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            actorLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor),
            actorLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: margin),
            actorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            actorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            actorLabel.heightAnchor.constraint(equalTo: movieNameLabel.heightAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
