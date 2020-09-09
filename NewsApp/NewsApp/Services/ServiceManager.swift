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
    func getNewsTotalNumber()
}

protocol NewsServiceCoordinatorDelegate: class {
    func serviceManagerDidLoadData(_ news: [News])
    func serviceManagerDidGetTotalNews(total: Int)
    func serviceManagerDidGetAnError(error: Error)
}

final class ServiceManager: NewsServiceCoordinator {
    
    weak var delegate: NewsServiceCoordinatorDelegate?
    private var apiService: RemoteNewsService
    private var dbService: LocalNewsService
    
    init(apiService: RemoteNewsService, dbService: LocalNewsService) {
        self.apiService = apiService
        self.dbService = dbService
    }
    
    func getData(page: Int) {
        if Constants.Logic.countOfDays > 0 {
            apiService.getData(page: page)
        } else {
            dbService.removeData()
            apiService.getData(page: page)
        }
    }
    
    func getNewsTotalNumber() {
        apiService.getNewsTotalNumber()
    }
    
}

extension ServiceManager: NewsServiceDelegate {
    
    func didLoadData(_ news: [News]) {
        delegate?.serviceManagerDidLoadData(news)
        DispatchQueue.main.async {
            self.dbService.saveData(news)
        }
    }
    
    func didGetTotalNews(total: Int) {
        delegate?.serviceManagerDidGetTotalNews(total: total)
    }
    
    func didGetAnError(error: Error) {
        delegate?.serviceManagerDidGetAnError(error: error)
    }
    
}
