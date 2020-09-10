//
//  NewsDetailsController.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/10/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

class NewsDelaisController {
    
    private var model: NewsDetailsManager
    private var view: NewsDetailsView
    
    init (model: NewsDetailsManager, view: NewsDetailsView) {
        self.model = model
        self.view = view
    }
    
}

extension NewsDelaisController: NewsDetailsViewDelegate {
    
    func viewDidLoad() {
        print("NewsDescriptionDidLoad")
    }
    
    func viewDidTapFavouriteButton(for viewModel: NewsViewModel) {
        model.updateFavourite(for: viewModel)
    }
    
}

extension NewsDelaisController: NewsDetailsManagerDelegate {
    
    func modelDidLoadNews(_ news: News) {
        view.updateView(NewsModel(news: news))
    }
    
    func modelDidGetAnError(error: Error) {
        view.showAnError(error: error)
    }
    
}
