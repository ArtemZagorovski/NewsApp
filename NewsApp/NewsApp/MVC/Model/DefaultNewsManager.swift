//
//  NewsLogic.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/2/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class DefaultNewsManager: NewsManager, DataManagerDelegate {
    
    var serviceManager: ServiceManager?
    var newsLogicDelegate: ModelDelegate?
    
    private var news: [News]?
    
    func loadNews() {
        serviceManager?.getData()
    }
    
    func filter(for text: String) {
        let searchNews = news?.filter { news -> Bool in
            return text.isEmpty ? true : (news.newsTitle.lowercased().contains(text.lowercased()) || news.newsDescription.lowercased().contains(text.lowercased()))
        }
        newsLogicDelegate?.modelDidLoadNews(searchNews!)
    }
    
    func updateFavourite() {
        print("New favourite")
    }
    
    func dataManagerDidLoadData(_ news: [News]) {
        self.news = news
        newsLogicDelegate?.modelDidLoadNews(news)
    }
    
}
