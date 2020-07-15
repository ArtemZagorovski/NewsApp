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

enum APIResult<T, Int> {
  case Success(T, Int)
  case Failure(Error)
}

typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void


class APIManager {
    let urlbase = "http://newsapi.org/v2/everything?q=Apple&from="
    let toDate = "T00:00:00&to="
    let sortAndApiKey = "T23:59:59&sortBy=popular&apiKey=6a2f2df98b7d4086a3aa0b9877d333a9"
    var currentDateString = ""
    
    func getNews(dateString: String, completionHandler: @escaping (APIResult<[News], Int>) -> Void){
        currentDateString = dateString
        guard let url = URL(string: urlbase + currentDateString + toDate + currentDateString + sortAndApiKey) else { return }
        print(url)
        var news = [News]()
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let HTTPResponse = response as? HTTPURLResponse else { return }
            
            switch HTTPResponse.statusCode {
            case 200:
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                    guard let totalNews = json!["totalResults"] as? Int else { return }
                    if let dictionary = json!["articles"] as? [[String: AnyObject]]{
                            dictionary.forEach { el in
                                news.append(News(JSON: (el))!)
                            }
                        } else {
                            return
                        }
                    completionHandler(.Success(news, totalNews))

                } catch let error as NSError {
                    print(error)
                }
            default:
                print("We have got response status \(HTTPResponse.statusCode)")
            }
        }
        dataTask.resume()
    }
    
}
