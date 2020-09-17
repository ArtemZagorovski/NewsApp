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
    private weak var view: NewsView?
    private var coordinator: NewsCoordinator?
    
    init (model: NewsManager, view: NewsView, coordinator: NewsCoordinator) {
        self.model = model
        self.view = view
        self.coordinator = coordinator
    }
}

extension NewsController: NewsViewDelegate {
    func viewDidLoad() {
        view?.animateActivity()
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
    
    func viewDidTapFavouriteButton(for viewModel: NewsViewModel, closure: @escaping () -> ()) {
        model.addToFavorite(News(viewModel: viewModel), closure: closure)
    }
    
    func viewDidTapCell(for viewModel: NewsViewModel) {
        coordinator?.showDetails(with: viewModel, view: view)
    }
}

extension NewsController: NewsManagerDelegate {
    func modelDidLoadNews(_ news: [News]) {
        let viewModels = news.map{ NewsModel(news: $0) }
        view?.updateView(viewModels)
    }
    
    func modelDidGetAnError(error: Error) {
        coordinator?.showAnError(error: error, view: view)
    }
}
