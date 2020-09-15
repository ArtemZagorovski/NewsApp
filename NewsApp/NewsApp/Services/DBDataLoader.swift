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
    private let persistentContainer = CoreDataStack().persistentContainer
    private let getContext: NSManagedObjectContext
    private let saveContext: NSManagedObjectContext
    weak var delegate: NewsServiceDelegate?
    private var newsFromBD: [News] = []
    
    init() {
        getContext = persistentContainer.viewContext
        saveContext = persistentContainer.newBackgroundContext()
    }
    
    func getData(page: Int) {
        do {
            guard let newsCD = try getContext.fetch(NewsEntity.fetchRequest()) as? [NewsEntity] else { return }
            newsFromBD = newsCD.compactMap { News(newsCD: $0) }
        }
        catch let error {
            delegate?.didGetAnError(error: error)
        }
        delegate?.didLoadData(newsFromBD)
    }
    
    func saveData(_ news: [News]) {
        
        news.forEach { news in
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
