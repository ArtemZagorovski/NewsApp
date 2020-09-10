//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class NewsCoordinator {
    
    private var mainView: UIViewController?
    
    func createNewsViewController() -> UIViewController {
        
        let view = NewsViewController()
        mainView = view
        let apiService = APIService()
        let dbService = DBDataLoader()
        let serviceManager = ServiceManager(apiService: apiService, dbService: dbService)
        let model = DefaultNewsManager(serviceManager: serviceManager)
        let controller = NewsController(model: model, view: view, coordinator: self)
        
        model.delegate = controller
        view.delegate = controller
        serviceManager.delegate = model
        apiService.delegate = serviceManager
        dbService.delegate = serviceManager
        
        return view
    }
    
    func createNewsDetailsCoordinator(with: NewsViewModel) {
        let newsDetailsCoordinator = NewsDetailsCoordinator()
        let newsDetailsViewController = newsDetailsCoordinator.createNewsDetailsViewController(with: with)
        mainView?.navigationController?.pushViewController(newsDetailsViewController, animated: true)
    }
    
}
