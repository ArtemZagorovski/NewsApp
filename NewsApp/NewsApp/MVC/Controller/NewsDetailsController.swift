//
//  NewsDetailsController.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/10/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class NewsDetailsController {
    private var model: NewsDetailsManager
    private var view: NewsDetailsView
    private var viewModel: NewsViewModel
    
    init (model: NewsDetailsManager, view: NewsDetailsView, viewModel: NewsViewModel) {
        self.model = model
        self.view = view
        self.viewModel = viewModel
    }
}

extension NewsDetailsController: NewsDetailsViewDelegate {
    func viewDidLoad() {
        view.updateView(viewModel)
    }
}

extension NewsDetailsController: NewsDetailsManagerDelegate {
    func modelDidGetAnError(error: Error) {
        print("error")
    }
}
