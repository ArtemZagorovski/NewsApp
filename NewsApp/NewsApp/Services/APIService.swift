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
        guard let url = URL(string: Constants.Api.urlbase
                                    + String(page)
                                    + Constants.Api.apiKey)
        else { return }
        var news = [News]()
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let HTTPResponse = response as? HTTPURLResponse else { return }
            
            switch HTTPResponse.statusCode {
            case 200:
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                    if let dictionary = json!["articles"] as? [[String: AnyObject]] {
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
