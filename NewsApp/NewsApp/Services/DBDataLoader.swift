//
//  DBDataLoader.swift
//  NewsApp
//
//  Created by Pavel Sakhanko on 16.07.20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import RealmSwift

struct DBDataLoader {

    static func getDataFromRealm() {
        if newsFromDB.count == 0 {
            mainPageLoadActivityIndicator.startAnimating()
            DBDataLoader.getDataFromAPI()
        }
        newsFromDB = realm.objects(News.self)
    }
    
    static func getDataFromAPI() {
        let date = Date().rewindDays(-self.countOfDays)
        let dateString = Formatter.getStringWithWeekDay(date: date)
        APIManager().getNews(dateString: dateString) {[weak self] result in
            switch result {
            case .Success(let news, let totalNews):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if self.countOfDays == 0 {
                        self.mainPageLoadActivityIndicator.stopAnimating()
                    }
                    news.forEach { (news) in
                        StorageManager.saveNews(news)
                    }
                    countOfDays += 1
                    DBDataLoader.getDataFromRealm()
                }
                self.totalNews = totalNews
            case .Failure(let error):
                print(error)
            }
        }
    }

}
