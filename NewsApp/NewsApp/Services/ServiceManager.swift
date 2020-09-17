//
//  ServiceManager.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

protocol NewsServiceCoordinator {
    func loadNews(page: Int)
    func loadNews()
    func updateFavorites(with news: News, closure: @escaping () -> ())
    func filter(for text: String)
}

protocol NewsServiceCoordinatorDelegate: class {
    func serviceManagerDidLoadData(_ news: [News])
    func serviceManagerDidGetAnError(error: Error)
}

final class ServiceManager: NewsServiceCoordinator {
    
    weak var defaultDelegate: NewsServiceCoordinatorDelegate?
    weak var favouriteDelegate: NewsServiceCoordinatorDelegate?
    private var apiService = APIService()
    private var dbService = DBDataLoader()
    private var newsFromBD: [News] = []
    
    init() {
        apiService.delegate = self
        dbService.delegate = self
    }
    
    func loadNews(page: Int) {
        apiService.loadNews(page: page)
    }
    
    func loadNews() {
        dbService.loadNews(page: 1)
    }

    func updateFavorites(with news: News, closure: @escaping () -> ()) {
        dbService.saveData(news, closure: closure)
    }
    
    func filter(for text: String) {
        dbService.filter(for: text)
    }
}

extension ServiceManager: NewsRemoteServiceDelegate {
    func didLoadData(_ news: [[String : AnyObject]]) {
        loadNews()
        let newsFromAPI = news.compactMap { News(JSON: $0) }
        newsFromAPI.filter { newsFromBD.contains($0) }.map { $0.isFavourite = true }
        defaultDelegate?.serviceManagerDidLoadData(newsFromAPI)
    }
    
    func didGetAnError(error: Error) {
        defaultDelegate?.serviceManagerDidGetAnError(error: error)
    }
}

extension ServiceManager: NewsLocalServiceDelegate {
    func didLoadData(_ news: [NewsEntity]) {
        newsFromBD = news.compactMap { News(newsCD: $0) }
        newsFromBD.map {$0.isFavourite = true}
        favouriteDelegate?.serviceManagerDidLoadData(newsFromBD)
    }
}
