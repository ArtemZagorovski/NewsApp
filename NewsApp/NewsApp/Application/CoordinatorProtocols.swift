//
//  CoordinatorProtocol.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/16/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

protocol DetailsManager {
    func showDetails(with viewModel: NewsViewModel)
}

extension DetailsManager {
    func showDetails(with viewModel: NewsViewModel, view: UIViewController) {
        let newsDetailsCoordinator = NewsDetailsCoordinator()
        let newsDetailsViewController = newsDetailsCoordinator.createViewController(with: viewModel)
        view.navigationController?.pushViewController(newsDetailsViewController, animated: true)
    }
}

protocol ErrorManager {
    func showAnError(error: Error)
}

extension ErrorManager {
    func showAnError(error: Error, view: UIViewController) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        view.present(alert, animated: true)
    }
}