//
//  FavouriteNewsCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/15/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class FavouriteNewsCoordinator: DetailsManager, ErrorManager {
    
    private weak var view: UIViewController?
    private let serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func createViewController() -> UIViewController {
        let view = NewsViewController()
        self.view = view
        let serviceManager = self.serviceManager
        let model = FavouriteNewsManager(serviceManager: serviceManager)
        let controller = FavouriteNewsController(model: model, view: view, coordinator: self)
        model.delegate = controller
        view.delegate = controller
        serviceManager.favouriteDelegate = model
        return view
    }
}
