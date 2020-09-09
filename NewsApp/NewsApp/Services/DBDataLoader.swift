//
//  DBDataLoader.swift
//  NewsApp
//
//  Created by Pavel Sakhanko on 16.07.20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import RealmSwift

class DBDataLoader {
    
    static var newsFromDB: Results<News>! {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.NotificationNames.newData), object: nil)
        }
    }

    static func getDataFromRealm() {
        DBDataLoader.newsFromDB = realm.objects(News.self)
        if newsFromDB != nil && newsFromDB.count == 0 {
            
        }
    }
    
    static func deleteAndGetNewData() {
        newsFromDB.forEach { (news) in
            RealmManager.deliteNews(news)
        }
        getDataFromRealm()
    }
}
