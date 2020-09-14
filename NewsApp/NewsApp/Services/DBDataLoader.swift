//
//  DBDataLoader.swift
//  NewsApp
//
//  Created by Pavel Sakhanko on 16.07.20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import CoreData

final class DBDataLoader: LocalNewsService {
    private let context = CoreDataStack().persistentContainer.viewContext
    private let getContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    private let saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    weak var delegate: NewsServiceDelegate?
    private var newsFromBD: [News] = []
    
    init() {
        getContext.parent = context
        saveContext.parent = context
    }
    
    func getData(page: Int) {
        do {
            guard let newsCD = try getContext.fetch(NewsEntity.fetchRequest()) as? [NewsEntity] else { return }
            newsFromBD = newsCD.compactMap{News(newsCD: $0)}
        }
        catch let error {
            delegate?.didGetAnError(error: error)
        }
        delegate?.didLoadData(newsFromBD)
    }
    
    func saveData(_ news: [News]) {
        news.forEach { news in
            getData(page: 1)
            if !newsFromBD.contains(news) {
                NewsEntity(news: news, context: saveContext)
            }
        }
        do {
            try saveContext.save()
        }
        catch let error {
            delegate?.didGetAnError(error: error)
        }
    }
}
