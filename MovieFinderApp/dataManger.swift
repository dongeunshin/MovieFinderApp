//
//  dataManger.swift
//  MovieFinderApp
//
//  Created by dong eun shin on 2022/01/18.
//

import Foundation

class dataManager {
    
    static let shared: dataManager = dataManager()
    let clientID = "k798N9BY5HzV05f0pRAG"
    let clientSecret = "DC4QVuVKGs"
    private init() {}
    
    var movieList: [Item] = []
    
    let apiQueue = DispatchQueue(label: "ApiQueue", attributes: .concurrent)
    
    let group = DispatchGroup()
    
    func fetch(queryValue: String, completion:  @escaping () -> ()) {
        group.enter()
        apiQueue.async {
            self.fetchMovie(queryValue: queryValue) { (result) in
                switch result {
                case .success(let data):
                    if let decodedData = data as? MovieModel {
                        self.movieList = decodedData.items
                    }
//                    return
                default:
                    self.movieList = []
                }
                self.group.leave()
            }
        }
        group.notify(queue: .main) {
            completion()
        }
    }
    
}
extension dataManager{
    private func fetchMovie(queryValue: String , completion: @escaping (Result<Any, Error>) -> ()){
        
        let urlString = "https://openapi.naver.com/v1/search/movie.json?query=\(queryValue)"
        
        guard let url = URL(string: urlString) else { return }
        
        var requestURl = URLRequest(url: url)
        requestURl.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        requestURl.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: requestURl) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
                        
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(MovieModel.self, from: data)
                completion(.success(data))
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
