//
//  APIManager.swift
//  NewsApp
//
//  Created by Артем  on 7/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    init?(JSON: [String: AnyObject])
}

final class APIService: RemoteNewsService {
    
    weak var delegate: NewsServiceDelegate?

    func getData(page: Int) {
        
        var components = URLComponents()
        components.scheme = Constants.Api.scheme
        components.host = Constants.Api.host
        components.path = Constants.Api.path
        components.queryItems = [
            URLQueryItem(name: "q", value: Constants.Api.q),
            URLQueryItem(name: "sortBy", value: Constants.Api.sortBy),
            URLQueryItem(name: "language", value: Constants.Api.language),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "apiKey", value: Constants.Api.apiKey)
        ]
        
        guard let url = components.url else { return }
        print(url)
        var news: [News] = []
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let HTTPResponse = response as? HTTPURLResponse else { return }
            
            switch HTTPResponse.statusCode {
            case 200:
                do {
                    guard let data = data, let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                    if let dictionary = json["articles"] as? [[String: AnyObject]] {
                            dictionary.forEach { el in
                                guard let newNews = News(JSON: (el)) else { return }
                                news.append(newNews)
                            }
                        } else {
                            return
                        }
                    self.delegate?.didLoadData(news)
                } catch let error as NSError {
                    print(error)
                }
            default:
                print("We have got response status \(HTTPResponse.statusCode)")
            }
            
            if let error = error {
                print(error.localizedDescription)
                self.delegate?.didGetAnError(error: error)
            }
            
            if let error = error {
                print(error.localizedDescription)
                self.delegate?.didGetAnError(error: error)
            }
        }
        dataTask.resume()
    }
    
}
