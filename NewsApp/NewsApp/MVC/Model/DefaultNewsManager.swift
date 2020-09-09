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
    private var pageTotalNumber = 0
    private var page = 1
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func loadNews() {
        serviceManager.getNewsTotalNumber()
        serviceManager.getData(page: page)
        page += 1
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
        serviceManager.getData(page: page)
        page = 1
    }
    
    func loadMoreNews() {
        serviceManager.getData(page: page)
        if pageTotalNumber > page {
            page += 1
        }
    }
    
    func updateFavourite() {
        print("New favourite")
    }
    
}

extension DefaultNewsManager: NewsServiceCoordinatorDelegate {
    
    func serviceManagerDidLoadData(_ news: [News]) {
        self.news = news
        delegate?.modelDidLoadNews(news)
    }
    
    func serviceManagerDidGetTotalNews(total: Int) {
        pageTotalNumber = total / 20
    }
    
    func serviceManagerDidGetAnError(error: Error) {
        delegate?.modelDidGetAnError(error: error)
    }
    
}
