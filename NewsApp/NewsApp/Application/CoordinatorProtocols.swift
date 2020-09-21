//
//  CoordinatorProtocol.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/16/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

protocol DetailsShowable {
    var viewController: UIViewController? { get }
    func showDetails(with viewModel: NewsViewModel)
}

extension DetailsShowable {
    func showDetails(with viewModel: NewsViewModel) {
        let newsDetailsCoordinator = NewsDetailsCoordinator()
        let newsDetailsViewController = newsDetailsCoordinator.createViewController(with: viewModel)
        viewController?.navigationController?.pushViewController(newsDetailsViewController, animated: true)
    }
}

protocol ErrorShowable {
    var viewController: UIViewController? { get }
    func showAnError(error: Error)
}

extension ErrorShowable {
    func showAnError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        viewController?.present(alert, animated: true)
    }
}
