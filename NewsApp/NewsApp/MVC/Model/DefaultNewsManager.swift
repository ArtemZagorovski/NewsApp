//
//  NewsLogic.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/2/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class DefaultNewsManager: NewsManager {
    private let apiService: RemoteNewsService
    private var dbService: LocalNewsService
    private var newsFromApi: [News] = []
    private var newsFromBD: [News] = []
    private var page = 1
    
    weak var delegate: NewsManagerDelegate?
    
    init(apiService: RemoteNewsService, dbService: LocalNewsService) {
        self.apiService = apiService
        self.dbService = dbService
        dbService.loadNews(page: 1)
    }
    
    func loadNews() {
        apiService.loadNews(page: page)
    }
    
    func filterAllNews(for text: String) {
        if text.isEmpty {
            delegate?.modelDidLoadNews(newsFromApi)
        } else {
            delegate?.modelDidLoadNews(newsFromApi.filter { news in
                let isTitleContainsFilter = news.newsTitle.lowercased().contains(text.lowercased())
                let isDescriptionContainsFilter = news.newsDescription.lowercased().contains(text.lowercased())
                return isTitleContainsFilter || isDescriptionContainsFilter
            })
        }
    }
    
    func refresh() {
        page = 1
        apiService.loadNews(page: page)
    }
    
    func loadMoreNews() {
        page += 1
        apiService.loadNews(page: page)
    }
    
    func saveData() {
        dbService.saveData(newsFromBD)
    }
    
    func updateFavorites(with news: News, refreshCell: @escaping () -> ()) {
        let equals = newsFromBD.filter { $0.id == news.id }
        if equals.isEmpty {
            news.isFavourite = !news.isFavourite
            newsFromBD.append(news)
        }
        else {
            guard let indexOfEqual = newsFromBD.firstIndex(of: equals[0]) else { return }
            newsFromBD.remove(at: indexOfEqual)
        }
        refreshCell()
    }
}

extension DefaultNewsManager: FavoriteNewsManager {
    func loadFavoriteNews() {
        delegate?.modelDidLoadFavoriteNews(newsFromBD)
    }
    
    func filterFavoriteNews(for text: String) {
        if text.isEmpty {
            delegate?.modelDidLoadNews(newsFromBD)
        } else {
            delegate?.modelDidLoadNews(newsFromBD.filter { news in
                let isTitleContainsFilter = news.newsTitle.lowercased().contains(text.lowercased())
                let isDescriptionContainsFilter = news.newsDescription.lowercased().contains(text.lowercased())
                return isTitleContainsFilter || isDescriptionContainsFilter
            })
        }
    }
}

extension DefaultNewsManager: NewsRemoteServiceDelegate {
    func didLoadData(_ news: [[String : AnyObject]]) {
        newsFromApi = news.compactMap { News(JSON: $0) }
        newsFromApi.filter { newsFromBD.contains($0) }.map { $0.isFavourite = true }
        delegate?.modelDidLoadNews(newsFromApi)
    }
    
    func didGetAnError(error: Error) {
        delegate?.modelDidGetAnError(error: error)
    }
}

extension DefaultNewsManager: NewsLocalServiceDelegate {
    func didLoadData(_ news: [NewsEntity]) {
        newsFromBD = news.compactMap { News(newsCD: $0) }
        newsFromBD.map {$0.isFavourite = true}
    }
}
