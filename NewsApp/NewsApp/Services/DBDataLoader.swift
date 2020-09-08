//
//  DBDataLoader.swift
//  NewsApp
//
//  Created by Pavel Sakhanko on 16.07.20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import RealmSwift

final class DBDataLoader: DataLoader, LocalDataChanger {
    
    weak var dbDataLoaderDelegate: DataLoaderDelegate?

    func getData() {
        dbDataLoaderDelegate?.didLoadData(Array(realm.objects(News.self)))
    }
    
    func saveData(_ news: [News]) {
        news.forEach { news in
            RealmManager.saveNews(news)
        }
    }
    
    func removeData() {
        realm.objects(News.self).forEach{ object in
            RealmManager.deleteNews(object)
        }
    }
}
