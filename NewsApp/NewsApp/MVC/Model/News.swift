//
//  News.swift
//  NewsApp
//
//  Created by Артем  on 7/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class News {
    let id: String
    let newsTitle: String
    let newsDescription: String
    let imageData: Data?
    let publishedAt: String?
    var isFavourite: Bool
    
    init (id: String, newsTitle: String, newsDescription: String, imageData: Data?, publishedAt: String?, isFavourite: Bool) {
        self.id = id
        self.newsTitle = newsTitle
        self.newsDescription = newsDescription
        self.imageData = imageData
        self.publishedAt = publishedAt
        self.isFavourite = isFavourite
    }
}

extension News: Equatable {
    static func == (lhs: News, rhs: News) -> Bool {
        return lhs.id == rhs.id
    }
}
