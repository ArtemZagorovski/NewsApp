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
    
    func filter(for text: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsEntity")
        if text.isEmpty {
            return
        }
        let predicate = NSPredicate(format: "newsTitle CONTAINS[c] %@", text)
        fetchRequest.predicate = predicate
        do {
            guard let fetchResult = try getContext.fetch(fetchRequest) as? [NewsEntity] else { return }
            delegate?.didLoadData(fetchResult)
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func saveData(_ news: News, closure: @escaping () -> ()) {
        do {
            guard let newsCD = try saveContext.fetch(NewsEntity.fetchRequest()) as? [NewsEntity] else { return }
            let equals = newsCD.filter { $0.id == news.id }
            if equals.isEmpty {
                NewsEntity(news: news, context: saveContext)
            } else {
                equals.map { saveContext.delete($0) }
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
        saveContext.perform {
            do {
                try self.saveContext.save()
                closure()
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
