//
//  NewsDetailsCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/10/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class NewsDetailsCoordinator {
    
    func createNewsDetailsViewController(with viewModel: NewsViewModel) -> UIViewController {
        
        let view = NewsDetailsViewController(news: viewModel)
        let model = DefaultNewsDetailsManager()
        let controller = NewsDelaisController(model: model, view: view)
        
        
        model.delegate = controller
        view.delegate = controller
        
        return view
    }
}
