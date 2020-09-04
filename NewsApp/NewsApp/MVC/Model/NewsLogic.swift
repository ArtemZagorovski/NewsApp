//
//  NewsLogic.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/2/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class NewsLogic: NewsManager, DataManagerDelegate {
    
    var serviceManager: ServiceManager?
    var newsLogicDelegate: ModelDelegate?
    
    func loadNews() {
        serviceManager?.getData()
    }
    
    func filter(for text: String) {
        print("filter for \(text)")
    }
    
    func updateFavourite() {
        print("New favourite")
    }
    
    func dataManagerDidLoadData(_ news: [News]) {
        newsLogicDelegate?.modelDidLoadNews(news)
    }
    
}
