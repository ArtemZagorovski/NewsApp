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
            DBDataLoader.getDataFromAPI()
        }
    }
    
    static func getDataFromAPI() {
        let date = Date().rewindDays(-Constants.Logic.countOfDays)
        let dateString = Formatter.getStringWithWeekDay(date: date)
        APIService().getNews(dateString: dateString) { result in
            switch result {
            case .Success(let news, let totalNews):
                DispatchQueue.main.async {
                    news.forEach { news in
                        RealmManager.saveNews(news)
                    }
                    Constants.Logic.countOfDays += 1
                    DBDataLoader.getDataFromRealm()
                }
                Constants.Logic.totalNews = totalNews
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    static func deleteAndGetNewData() {
        newsFromDB.forEach { (news) in
            RealmManager.deliteNews(news)
        }
        getDataFromRealm()
    }
}
