//
//  News.swift
//  NewsApp
//
//  Created by Артем  on 7/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class News {
    let newsTitle: String
    let newsDescription: String
    let imageData: Data?
    let publishedAt: String?
    var isFavourite: Bool = false
    
    private init (newsTitle: String, newsDescription: String, imageData: Data?, publishedAt: String?, isFavourite: Bool) {
        self.newsTitle = newsTitle
        self.newsDescription = newsDescription
        self.imageData = imageData
        self.publishedAt = publishedAt
        self.isFavourite = isFavourite
    }
}

extension News {
    convenience init?(JSON: [String : AnyObject]) {
        guard let title = JSON["title"] as? String,
            let description = JSON["description"] as? String,
            let publishedAt = JSON["publishedAt"] as? String else {
                return nil
        }
        
        var imageData: Data? = nil
        do {
            let imageUrlString = JSON["urlToImage"]
            if imageUrlString is NSNull {
                imageData = nil
            } else {
                if let imageUrl = URL(string: imageUrlString as! String) {
                    imageData = try Data(contentsOf: imageUrl)
                } else {
                    print("imageUrlString is not an image")
                }
            }
        } catch let error {
            print("error \(error.localizedDescription)")
        }

        self.init(newsTitle: title, newsDescription: description, imageData: imageData, publishedAt: publishedAt, isFavourite: false)
    }
}

extension News {
    convenience init?(newsCD: NewsCoreData) {
        guard let title = newsCD.newsTitle, let description = newsCD.newsDescription else { return nil }
        self.init(newsTitle: title, newsDescription: description, imageData: newsCD.imageData, publishedAt: newsCD.publishedAt, isFavourite: newsCD.isFavourite)
    }
}
