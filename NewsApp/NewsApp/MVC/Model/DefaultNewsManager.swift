//
//  NewsLogic.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/2/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class DefaultNewsManager: NewsManager {
    private let apiService = APIService()
    private let dbService = DBDataLoader()
    private var newsFromApi: [News] = []
    private var newsFromBD: [News] = []
    private var page = 1
    
    weak var delegate: NewsManagerDelegate?
    
    init() {
        self.apiService.delegate = self
        self.dbService.delegate = self
        dbService.loadNews(page: 1)
    }
    
    func loadNews() {
        apiService.loadNews(page: page)
    }
    
    func filter(favorite: Bool, for text: String) {
        let news = favorite ? newsFromBD : newsFromApi
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
        apiService.loadNews(page: page)
    }
    
    func loadMoreNews() {
        page += 1
        apiService.loadNews(page: page)
    }
    
    func saveData() {
        dbService.saveData(newsFromBD)
    }
    
    func updateFavorites(with news: News, isFavorite: Bool, refreshCell: @escaping () -> ()) {
        if isFavorite {
            guard let indexOfEqual = newsFromBD.firstIndex(of: news) else { return }
            newsFromBD.remove(at: indexOfEqual)
        }
        else {
            news.isFavourite = !news.isFavourite
            newsFromBD.append(news)
        }
        refreshCell()
    }
}

extension DefaultNewsManager: FavoriteNewsManager {
    func loadFavoriteNews() {
        delegate?.modelDidLoadNews(newsFromBD)
    }
}

extension DefaultNewsManager: NewsRemoteServiceDelegate {
    func didLoadData(_ news: [[String : AnyObject]]) {
        newsFromApi = news.compactMap { News(JSON: $0) }
        newsFromApi.forEach { $0.isFavourite = newsFromBD.contains($0) }
        delegate?.modelDidLoadNews(newsFromApi)
    }
    
    func didGetAnError(error: Error) {
        delegate?.modelDidGetAnError(error: error)
    }
}

extension DefaultNewsManager: NewsLocalServiceDelegate {
    func didLoadData(_ news: [NewsEntity]) {
        newsFromBD = news.compactMap { News(newsCD: $0) }
        newsFromBD.forEach {$0.isFavourite = true}
    }
}
