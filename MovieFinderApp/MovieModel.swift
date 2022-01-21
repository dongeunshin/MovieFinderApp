//
//  MovieModel.swift
//  MovieFinderApp
//
//  Created by dong eun shin on 2022/01/18.
//

import Foundation

struct MovieModel: Codable {
//    let total: Int
    let items: [Item]
}

struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let subtitle, pubDate, director, actor: String
    let userRating: String
}
