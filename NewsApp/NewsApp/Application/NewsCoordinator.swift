//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class NewsCoordinator {
    
    func createNewsViewController() -> UIViewController {
        
        let model = NewsLogic()
        let view = NewsViewController()
        let serviceManager = ServiceManager()
        let apiService = APIService()
        let dbService = DBDataLoader()
        let interpreter = Interpreter(model: model, view: view)
        
        model.newsLogicDelegate = interpreter
        model.serviceManager = serviceManager
        view.viewDelegate = interpreter
        serviceManager.serviceManagerDelegate = model
        serviceManager.apiService = apiService
        serviceManager.dbService = dbService
        apiService.apiServiceDelegate = serviceManager
        dbService.dbDataLoaderDelegate = serviceManager
        
        return view
    }
    
}
