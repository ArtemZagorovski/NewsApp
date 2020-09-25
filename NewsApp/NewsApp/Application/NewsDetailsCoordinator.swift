//
//  NewsDetailsCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/10/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class NewsDetailsCoordinator {
    func createViewController(with viewModel: NewsViewModel) -> UIViewController {
        let view = NewsDetailsViewController()
        let controller = NewsDetailsController(view: view, viewModel: viewModel)
        view.controller = controller
        return view
    }
}
