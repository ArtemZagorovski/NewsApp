//
//  NewsLogic.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/2/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class DefaultNewsManager: MainNewsDataProvider {
    private let apiService: RemoteNewsService
    private let dbService: LocalNewsService
    private var newsFromApi: [News] = []
    private var newsFromDB: [News] = []
    private var page = 1
    
    weak var delegate: NewsManagerDelegate?
    
    init(apiService: RemoteNewsService, dbService: LocalNewsService) {
        self.apiService = apiService
        self.dbService = dbService
        self.apiService.delegate = self
        self.dbService.delegate = self
        dbService.loadNews()
    }
    
    func news(onlyFavorite: Bool, filter: String?) -> [News] {
        let news = onlyFavorite ? newsFromDB : newsFromApi
        guard let filterText = filter, filterText.isEmpty == false else { return news }
        return news.filter { news in
            let isTitleContainsFilter = news.newsTitle.lowercased().contains(filterText.lowercased())
            let isDescriptionContainsFilter = news.newsDescription.lowercased().contains(filterText.lowercased())
            return isTitleContainsFilter || isDescriptionContainsFilter
        }
    }
    
    func loadNews() {
        apiService.loadNews(page: page)
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
        dbService.saveData(newsFromDB)
    }
    
    func updateFavorites(with news: News, currentFavoriteState: Bool, completion: () -> Void) {
        if currentFavoriteState, let indexOfEqual = newsFromDB.firstIndex(of: news) {
            newsFromDB.remove(at: indexOfEqual)
            completion()
        } else {
            news.isFavorite = !currentFavoriteState
            newsFromDB.append(news)
            completion()
        }
    }
}

extension DefaultNewsManager: FavoriteNewsDataProvider {
    func loadFavoriteNews() {
        delegate?.modelDidLoadNews()
    }
}

extension DefaultNewsManager: NewsRemoteServiceDelegate {
    func didLoadData(_ news: [[String: AnyObject]]) {
        newsFromApi = news.compactMap { News(JSON: $0) }
        newsFromApi.forEach { $0.isFavorite = newsFromDB.contains($0) }
        delegate?.modelDidLoadNews()
    }
    
    func didGetAnError(error: Error) {
        delegate?.modelDidGetAnError(error: error)
    }
}

extension DefaultNewsManager: NewsLocalServiceDelegate {
    func didLoadData(_ news: [NewsEntity]) {
        newsFromDB = news.compactMap { News(newsCD: $0) }
        newsFromDB.forEach { $0.isFavorite = true }
    }
}
