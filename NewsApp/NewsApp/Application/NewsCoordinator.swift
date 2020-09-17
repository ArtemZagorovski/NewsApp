//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class NewsCoordinator: DetailsManager, ErrorManager {
    private weak var view: UIViewController?
    private var serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func createViewController() -> UIViewController {
        let view = NewsViewController()
        self.view = view
        let serviceManager = self.serviceManager
        let model = DefaultNewsManager(serviceManager: serviceManager)
        let controller = NewsController(model: model, view: view, coordinator: self)
        model.delegate = controller
        view.delegate = controller
        serviceManager.defaultDelegate = model
        return view
    }
}
