//
//  NetworkManager .swift
//  NYT news
//
//  Created by Ayman Ata on 8/12/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit


class NetworkManager {
    static let shared = NetworkManager()
    private let key = "VLDsMp506amUnygeDxMdywr3aIGySwMP"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getArticles(for category: ArticleCategory, completionHandler: @escaping (Result<[Article],NYError>) -> Void) {
        let baseURL = "https://api.nytimes.com/svc/topstories/v2/\(category.rawValue).json?api-key="

        let endPoint = baseURL + key
        guard let url = URL(string: endPoint) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let respond = try decoder.decode(Respond.self, from: data)
                completionHandler(.success(respond.results))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getArticleImage(for stringUrl: String, completionHandler: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: stringUrl)
        if let image = cache.object(forKey: cacheKey) {
            completionHandler(image)
            return
        }
        
        guard let url = URL(string: stringUrl) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            if let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: cacheKey)
                completionHandler(image)
                return
            }
        }
        task.resume()
    }
}
