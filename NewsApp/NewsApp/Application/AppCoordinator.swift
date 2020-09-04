//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    func createView() -> UIViewController {
        
        let model = NewsLogic()
        let view = NewsViewController()
        let serviceManager = ServiceManager()
        let apiService = APIService()
        let interpreter = Interpreter(model: model, view: view)
        
        model.newsLogicDelegate = interpreter
        model.serviceManager = serviceManager
        view.viewDelegate = interpreter
        serviceManager.serviceManagerDelegate = model
        serviceManager.apiService = apiService
        apiService.apiServiceDelegate = serviceManager
        
        return view
    }
    
}
