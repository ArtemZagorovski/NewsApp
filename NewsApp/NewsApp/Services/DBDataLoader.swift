//
//  DBDataLoader.swift
//  NewsApp
//
//  Created by Pavel Sakhanko on 16.07.20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import RealmSwift

final class DBDataLoader: LocalNewsService {
    
    private let context = CoreDataStack().persistentContainer.viewContext
    weak var delegate: NewsServiceDelegate?

    func getData(page: Int) {
        var news: [News] = []
        do {
            guard let newsCD = try context.fetch(NewsCoreData.fetchRequest()) as? [NewsCoreData] else { return }
            news = newsCD.map{News(newsCD: $0)}
        }
        catch let error {
            delegate?.didGetAnError(error: error)
        }
        delegate?.didLoadData(news)
    }
    
    func saveData(_ news: [News]) {
        news.forEach { news in
            NewsCoreData(news: news, context: context)
        }
        do {
            try context.save()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}
