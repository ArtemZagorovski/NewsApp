//
//  NewsLogic.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/2/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class DefaultNewsManager: NewsManager {
    
    private var serviceManager: ServiceManager
    weak var delegate: NewsManagerDelegate?
    
    private var news: [News]?
    private var countOfDays = 0
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func loadNews() {
        serviceManager.getData(date: computeDate())
        countOfDays += 1
    }
    
    func filter(for text: String) {
        if !text.isEmpty {
            news = news?.filter { news in
                let isTitleContainsFilter = news.newsTitle.lowercased().contains(text.lowercased())
                let isDescriptionContainsFilter = news.newsDescription.lowercased().contains(text.lowercased())
                return isTitleContainsFilter || isDescriptionContainsFilter
            }
        }
        guard let news = news else { return }
        delegate?.modelDidLoadNews(news)
    }
    
    func refresh() {
        countOfDays = 0
        serviceManager.getData(date: computeDate())
    }
    
    func loadMoreNews() {
        serviceManager.getData(date: computeDate())
        countOfDays += 1
    }
    
    func updateFavourite() {
        print("New favourite")
    }
    
    func computeDate() -> String {
        let date = Date().rewindDays(-countOfDays)
        return Formatter.getStringWithWeekDay(date: date)
    }
    
}

extension DefaultNewsManager: NewsServiceCoordinatorDelegate {
    
    func dataManagerDidLoadData(_ news: [News]) {
        self.news = news
        delegate?.modelDidLoadNews(news)
    }
    
    func dataManagerDidGetAnError(error: Error) {
        delegate?.modelDidGetAnError(error: error)
    }
    
}
