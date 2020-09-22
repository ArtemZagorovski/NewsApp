//
//  News+initFromBD.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/15/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

extension News {
    convenience init(newsCD: NewsEntity) {
        self.init(id: newsCD.id,
                  newsTitle: newsCD.newsTitle,
                  newsDescription: newsCD.newsDescription,
                  imageData: newsCD.imageData,
                  publishedAt: newsCD.publishedAt,
                  isFavorite: newsCD.isFavorite)
    }
}
