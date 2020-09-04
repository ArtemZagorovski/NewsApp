//
//  ServiceManager.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

class ServiceManager: DataLoader, DataLoaderDelegate {
    
    var serviceManagerDelegate: DataManagerDelegate?
    var apiService: DataLoader?
    
    func didLoadData(_ news: [News]) {
        serviceManagerDelegate?.dataManagerDidLoadData(news)
    }
    
    func getData() {
        apiService?.getData()
    }
    
}
