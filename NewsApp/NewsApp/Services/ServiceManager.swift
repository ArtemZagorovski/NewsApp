//
//  ServiceManager.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

protocol NewsServiceCoordinator {
    func getData(page: Int)
}

protocol NewsServiceCoordinatorDelegate: class {
    func dataManagerDidLoadData(_ news: [News])
    func dataManagerDidGetAnError(error: Error)
}

final class ServiceManager: NewsServiceCoordinator {
    
    weak var delegate: NewsServiceCoordinatorDelegate?
    private var apiService: RemoteNewsService?
    private var dbService: LocalNewsService?
    
    init(apiService: RemoteNewsService, dbService: LocalNewsService) {
        self.apiService = apiService
        self.dbService = dbService
    }
    
    func getData(page: Int) {
        if Constants.Logic.countOfDays > 0 {
            apiService?.getData(page: page)
        } else {
            dbService?.removeData()
            apiService?.getData(page: page)
        }
    }
    
}

extension ServiceManager: NewsServiceDelegate {
    
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
