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
    weak var delegate: NewsLocalServiceDelegate?
    
    init() {
        getContext = persistentContainer.viewContext
        saveContext = persistentContainer.newBackgroundContext()
    }
    
    func loadNews(page: Int) {
        do {
            guard let newsCD = try getContext.fetch(NewsEntity.fetchRequest()) as? [NewsEntity] else { return }
            delegate?.didLoadData(newsCD)
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func saveData(_ news: [News]) {
        do {
            guard let newsCD = try saveContext.fetch(NewsEntity.fetchRequest()) as? [NewsEntity] else { return }
            newsCD.forEach { saveContext.delete($0) }
            news.forEach { NewsEntity(news: $0, context: saveContext) }
        }
        catch let error {
            print(error.localizedDescription)
        }
        saveContext.perform {
            do {
                try self.saveContext.save()
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
