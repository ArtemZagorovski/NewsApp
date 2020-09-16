//
//  FavouriteNewsCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/15/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class FavouriteNewsCoordinator {
    private weak var view: UIViewController?
    private let serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func createViewController() -> UIViewController {
        let view = NewsViewController()
        self.view = view
        let serviceManager = serviceContainer.serviceManager
        let model = FavouriteNewsManager(serviceManager: serviceManager)
        let controller = FavouriteNewsController(model: model, view: view, coordinator: self)
        model.delegate = controller
        view.delegate = controller
        serviceManager.favouriteDelegate = model
        return view
    }
    
    func showDetails(with viewModel: NewsViewModel) {
        let newsDetailsCoordinator = NewsDetailsCoordinator()
        let newsDetailsViewController = newsDetailsCoordinator.createViewController(with: viewModel)
        view?.navigationController?.pushViewController(newsDetailsViewController, animated: true)
    }
    
    func showAnError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        view?.present(alert, animated: true)
    }
}
