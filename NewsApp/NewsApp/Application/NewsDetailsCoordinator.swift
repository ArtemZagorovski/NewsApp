//
//  NewsDetailsCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/10/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class NewsDetailsCoordinator {
    
    func createNewsDetailsViewController(with viewModel: NewsViewModel) -> UIViewController {
        let view = NewsDetailsViewController()
        let model = DefaultNewsDetailsManager()
        let controller = NewsDetailsController(model: model, view: view, viewModel: viewModel)
        model.delegate = controller
        view.delegate = controller
        return view
    }
}
