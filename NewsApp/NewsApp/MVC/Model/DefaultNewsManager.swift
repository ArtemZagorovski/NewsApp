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
    weak var newsLogicDelegate: ModelDelegate?
    
    private var news: [News]?
    
    func loadNews() {
        serviceManager?.getData()
        Constants.Logic.countOfDays += 1
    }
    
    func filter(for text: String) {
        let searchNews = news?.filter { news in
            let isTitleContainsFilter = news.newsTitle.lowercased().contains(text.lowercased())
            let isDescriptionContainsFilter = news.newsDescription.lowercased().contains(text.lowercased())
            return text.isEmpty ? true : isTitleContainsFilter || isDescriptionContainsFilter
        }
        newsLogicDelegate?.modelDidLoadNews(searchNews!)
    }
    
    func refresh() {
        Constants.Logic.countOfDays = 0
        serviceManager?.getData()
    }
    
    func loadMoreNews() {
        serviceManager?.getData()
        Constants.Logic.countOfDays += 1
    }
    
    func updateFavourite() {
        print("New favourite")
    }
    
    func dataManagerDidLoadData(_ news: [News]) {
        self.news = news
        newsLogicDelegate?.modelDidLoadNews(news)
    }
    
}
