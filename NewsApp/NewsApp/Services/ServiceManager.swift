//
//  ServiceManager.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

class ServiceManager: DataLoader, DataLoaderDelegate {
    
    weak var serviceManagerDelegate: DataManagerDelegate?
    var apiService: DataLoader?
    var dbService: LocalDataChanger?
    
    func didLoadData(_ news: [News]) {
        serviceManagerDelegate?.dataManagerDidLoadData(news)
        DispatchQueue.main.async {
            self.dbService?.saveData(news)
        }
    }
    
    func getData() {
        if Constants.Logic.countOfDays > 0 {
            apiService?.getData()
        } else {
            dbService?.removeData()
            apiService?.getData()
            
        }
    }
    
}
