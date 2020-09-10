//
//  Interpreter.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class NewsController {
    
    private var model: NewsManager
    private var view: NewsView
    
    init (model: NewsManager, view: NewsView) {
        self.model = model
        self.view = view
    }
    
}

extension NewsController: NewsViewDelegate {
    
    func viewDidLoad() {
        view.animateActivity()
        model.loadNews()
    }
    
    func viewDidScrollToEnd() {
        model.loadMoreNews()
    }
    
    func viewDidPullToRefresh() {
        model.refresh()
    }
    
    func viewDidChangeSearchTerm(_ term: String) {
        model.filter(for: term)
    }
    
    func viewDidTapFavouriteButton(for viewModel: [NewsViewModel]) {
        model.updateFavourite()
    }
    
}

extension NewsController: NewsManagerDelegate {
    
    func modelDidLoadNews(_ news: [News]) {
        let viewModels = news.map{ NewsModel(news: $0) }
        view.updateView(viewModels)
    }
    
    func modelDidGetAnError(error: Error) {
        view.showAnError(error: error)
    }
}
