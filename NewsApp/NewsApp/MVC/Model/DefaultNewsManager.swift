//
//  NewsLogic.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/2/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class DefaultNewsManager {
    
    private var serviceManager: ServiceManager?
    weak var delegate: NewsManagerDelegate?
    
    private var news: [News]?
    private var searchNews: [News]?
    private var countOfDays = 0
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func computeDate() -> String {
        let date = Date().rewindDays(-countOfDays)
        return Formatter.getStringWithWeekDay(date: date)
    }
    
}

extension DefaultNewsManager: NewsManager {
    
    func loadNews() {
        serviceManager?.getData(date: computeDate())
        countOfDays += 1
    }
    
    func filter(for text: String) {
        if text.isEmpty {
            searchNews = news
        } else {
            searchNews = news?.filter { news in
                let isTitleContainsFilter = news.newsTitle.lowercased().contains(text.lowercased())
                let isDescriptionContainsFilter = news.newsDescription.lowercased().contains(text.lowercased())
                return isTitleContainsFilter || isDescriptionContainsFilter
            }
        }
        guard let searchNews = searchNews else { return }
        delegate?.modelDidLoadNews(searchNews)
    }
    
    func refresh() {
        countOfDays = 0
        serviceManager?.getData(date: computeDate())
    }
    
    func loadMoreNews() {
        serviceManager?.getData(date: computeDate())
        countOfDays += 1
    }
    
    func updateFavourite() {
        print("New favourite")
    }
    
}

extension DefaultNewsManager: ServiceManagerDelegate {
    
    func dataManagerDidLoadData(_ news: [News]) {
        self.news = news
        delegate?.modelDidLoadNews(news)
    }
    
    func dataManagerDidGetAnError(error: Error) {
        delegate?.modelDidGetAnError(error: error)
    }
    
}
