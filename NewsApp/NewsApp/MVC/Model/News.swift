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
    
    init (newsTitle: String, newsDescription: String, imageData: Data?, publishedAt: String?, isFavourite: Bool) {
        self.newsTitle = newsTitle
        self.newsDescription = newsDescription
        self.imageData = imageData
        self.publishedAt = publishedAt
        self.isFavourite = isFavourite
    }
}

extension News: Equatable {
    static func == (lhs: News, rhs: News) -> Bool {
        return lhs.newsTitle == rhs.newsTitle && lhs.newsDescription == rhs.newsDescription
    }
}
