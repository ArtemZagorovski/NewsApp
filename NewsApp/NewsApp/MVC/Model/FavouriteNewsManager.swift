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
    private var news: [News] = []
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func loadNews() {
        serviceManager.getLocalData()
    }
    
    func filter(for text: String) {
        
    }
    
    func refresh() {
        serviceManager.getLocalData()
    }
    
    func loadMoreNews() {
        
    }
    
    func updateFavourite() {
        
    }
}
