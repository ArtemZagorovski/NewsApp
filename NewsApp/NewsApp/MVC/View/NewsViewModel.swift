//
//  ViewModel.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/7/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

struct NewsViewModel: ViewModel {
    var newsTitle: String
    var newsDescription: String
    var image: UIImage?
    var publishedAt: String?
    var isFavourite: Bool = false
}

extension NewsViewModel {
    
    init (news: News) {
        
        if let imageData = news.imageData {
            self.image = UIImage(data: imageData)
        } else {
            self.image = nil
        }
        
        self.newsTitle = news.newsTitle
        self.newsDescription = news.newsDescription
        self.publishedAt = news.publishedAt
        self.isFavourite = news.isFavourite
        
    }
    
}
