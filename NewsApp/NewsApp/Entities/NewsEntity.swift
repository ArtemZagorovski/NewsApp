//
//  NewsCoreData+Class.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/11/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import CoreData

final class NewsEntity: NSManagedObject {
    @nonobjc
    class func fetchRequest() -> NSFetchRequest<NewsEntity> {
        return NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
    }
    @NSManaged var id: String
    @NSManaged var newsTitle: String
    @NSManaged var newsDescription: String
    @NSManaged var isFavorite: Bool
    @NSManaged var publishedAt: String?
    @NSManaged var imageData: Data?
}

extension NewsEntity {
    @discardableResult
    convenience init(news: News, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = news.id
        self.newsTitle = news.newsTitle
        self.newsDescription = news.newsDescription
        self.isFavorite = news.isFavorite
        self.publishedAt = news.publishedAt
        self.imageData = news.imageData
    }
}
