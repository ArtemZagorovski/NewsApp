//
//  News.swift
//  NewsApp
//
//  Created by Артем  on 7/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import RealmSwift

final class News: Object {
    
    @objc dynamic var newsTitle: String = ""
    @objc dynamic var newsDescription: String = ""
    @objc dynamic var imageData: Data?
    @objc dynamic var publishedAt: String?
    @objc dynamic var isFavourite: Bool = false
    
}

extension News: JSONDecodable {
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

        self.init()
        
        self.newsTitle = title
        self.newsDescription = description
        self.imageData = imageData
        self.publishedAt = publishedAt
    }
}
