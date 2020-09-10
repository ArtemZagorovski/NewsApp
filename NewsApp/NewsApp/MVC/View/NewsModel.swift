//
//  ViewModel.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/7/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

struct NewsModel: NewsViewModel {
    var newsTitle: String
    var newsDescription: String
    var image: UIImage?
    var publishedAt: String?
    var isFavourite: Bool = false
}

extension NewsModel {
    
    init (news: News) {
        self.image = news.imageData.map { UIImage(data: $0) } ?? nil
        self.newsTitle = news.newsTitle
        self.newsDescription = news.newsDescription
        self.publishedAt = news.publishedAt
        self.isFavourite = news.isFavourite
    }
    
}
