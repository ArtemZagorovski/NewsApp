//
//  FavouriteNewsManager.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/14/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import CoreData

final class FavouriteNewsManager: NewsManager {
    private var serviceManager: ServiceManager
    weak var delegate: NewsManagerDelegate?
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func loadNews() {
        serviceManager.loadNews()
    }
    
    func filter(for text: String) {
        serviceManager.filter(for: text)
    }
    
    func refresh() {
        serviceManager.loadNews()
    }
    
    func loadMoreNews() {
        serviceManager.loadNews()
    }
    
    func addToFavorite(_ news: News, closure: @escaping () -> ()) {
        serviceManager.updateFavorites(with: news, closure: closure)
    }
}

extension FavouriteNewsManager: NewsServiceCoordinatorDelegate {
    func serviceManagerDidLoadData(_ news: [News]) {
        delegate?.modelDidLoadNews(news)
    }
    
    func serviceManagerDidGetAnError(error: Error) {
        delegate?.modelDidGetAnError(error: error)
    }
}
