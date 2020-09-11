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
    
    private var news: [News] = []
    private var page = 1
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func loadNews() {
        serviceManager.getData(page: page)
    }
    
    func filter(for text: String) {
        if text.isEmpty {
            delegate?.modelDidLoadNews(news)
        } else {
            delegate?.modelDidLoadNews(news.filter { news in
                let isTitleContainsFilter = news.newsTitle.lowercased().contains(text.lowercased())
                let isDescriptionContainsFilter = news.newsDescription.lowercased().contains(text.lowercased())
                return isTitleContainsFilter || isDescriptionContainsFilter
            })
        }
    }
    
    func refresh() {
        page = 1
        serviceManager.getData(page: page)
    }
    
    func loadMoreNews() {
        serviceManager.getData(page: page)
    }
    
    func updateFavourite() {
        print("New favourite")
    }
    
}

extension DefaultNewsManager: NewsServiceCoordinatorDelegate {
    func serviceManagerDidLoadData(_ news: [News]) {
        self.news = news
        delegate?.modelDidLoadNews(news)
        page += 1
    }
    
    func serviceManagerDidGetAnError(error: Error) {
        delegate?.modelDidGetAnError(error: error)
    }
}
