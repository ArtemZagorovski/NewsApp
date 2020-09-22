//
//  ViewModel.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/7/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

struct NewsModel: NewsViewModel {
    let id: String
    let newsTitle: String
    let newsDescription: String
    let image: UIImage?
    let publishedAt: String?
    var isFavorite: Bool
}

extension NewsModel {
    init (news: News) {
        self.image = news.imageData.map { UIImage(data: $0) } ?? nil
        self.id = news.id
        self.newsTitle = news.newsTitle
        self.newsDescription = news.newsDescription
        self.publishedAt = news.publishedAt
        self.isFavorite = news.isFavorite
    }
}
