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
    
    private let persistentContainer = CoreDataStack.persistentContainer
    private let getContext: NSManagedObjectContext
    private let saveContext: NSManagedObjectContext
    weak var delegate: NewsLocalServiceDelegate?
    private var newsFromBD: [NewsEntity] = []
    
    init() {
        getContext = persistentContainer.viewContext
        saveContext = persistentContainer.newBackgroundContext()
    }
    
    func getData(page: Int) {
        getCurrentState()
        delegate?.didLoadData(newsFromBD)
    }
    
    private func getCurrentState() {
        do {
            guard let newsCD = try getContext.fetch(NewsEntity.fetchRequest()) as? [NewsEntity] else { return }
            newsFromBD = newsCD
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
            newsFromBD = fetchResult
        }
        catch let error {
            print(error.localizedDescription)
        }
        delegate?.didLoadData(newsFromBD)
    }
    
    func saveData(_ news: News, closure: () -> ()) {
        getCurrentState()
        let equals = newsFromBD.filter { $0.id == news.id }
        if equals.isEmpty {
            NewsEntity(news: news, context: saveContext)
        } else {
            equals.map { getContext.delete($0) }
            getData(page: 1)
        }
        do {
            try saveContext.save()
            closure()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}
