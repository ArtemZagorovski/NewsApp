//
//  News+initFromAPI.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/15/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

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
                if let imageUrlString = imageUrlString as? String, let imageUrl = URL(string: imageUrlString) {
                    imageData = try Data(contentsOf: imageUrl)
                } else {
                    print("imageUrlString is not an image")
                }
            }
        } catch let error {
            Logger.shared.logError(error: error)
        }

        self.init(newsTitle: title,
                  newsDescription: description,
                  imageData: imageData,
                  publishedAt: publishedAt,
                  isFavourite: false)
    }
}
