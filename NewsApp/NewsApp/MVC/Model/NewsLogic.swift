//
//  NewsLogic.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/2/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class NewsLogic: NewsManager, DataManagerDelegate {
    
    var serviceManager: ServiceManager?
    var newsLogicDelegate: ModelDelegate?
    
    var news: [News]?
    
    func loadNews() {
        serviceManager?.getData()
    }
    
    func filter(for text: String, isSearchBarEmpty: Bool) {
        let searchNews = news?.filter { (news: News?) -> Bool in
            guard let news = news else { return false }
            
            return isSearchBarEmpty ? true : (news.newsTitle.lowercased().contains(text.lowercased()) || news.newsDescription.lowercased().contains(text.lowercased()))
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
