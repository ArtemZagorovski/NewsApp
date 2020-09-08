//
//  ServiceManager.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class ServiceManager {
    
    weak var delegate: ServiceManagerDelegate?
    private var apiService: DataLoader?
    private var dbService: LocalDataChanger?
    
    init(apiService: DataLoader, dbService: LocalDataChanger) {
        self.apiService = apiService
        self.dbService = dbService
    }
    
}

extension ServiceManager: DataManager {
    
    func getData(date: String) {
        if Constants.Logic.countOfDays > 0 {
            apiService?.getData(date: date)
        } else {
            dbService?.removeData()
            apiService?.getData(date: date)
        }
    }
    
}

extension ServiceManager: DataLoaderDelegate {
    
    func didLoadData(_ news: [News]) {
        delegate?.dataManagerDidLoadData(news)
        DispatchQueue.main.async {
            self.dbService?.saveData(news)
        }
    }
    
    func didGetAnError(error: Error) {
        delegate?.dataManagerDidGetAnError(error: error)
    }
    
}
