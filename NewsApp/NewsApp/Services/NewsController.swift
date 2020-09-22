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
    var isFavoriteViewController: Bool {
        return false
    }
    
    func isNeedToRefreshCell() -> Bool {
        return true
    }
    
    func viewWillAppear() {
        view?.animateActivity()
        model.delegate = self
        model.loadNews()
    }
    
    func viewDidScrollToEnd() {
        model.loadMoreNews()
    }
    
    func viewDidPullToRefresh() {
        model.refresh()
    }
    
    func viewDidChangeSearchTerm(_ term: String) {
        model.filter(favorite: false, for: term)
    }
    
    func viewDidTapFavoriteButton(for viewModel: NewsViewModel, currentFavoriteState: Bool, refreshCell: @escaping () -> ()) {
        if currentFavoriteState {
            model.removeFromFavorites(news: News(viewModel: viewModel), isFavoriteView: false, refreshCell: refreshCell)
        } else {
            model.addToFavorites(news: News(viewModel: viewModel), refreshCell: refreshCell)
        }
    }
    
    func viewDidTapCell(for viewModel: NewsViewModel) {
        coordinator?.showDetails(with: viewModel)
    }
}

extension NewsController: NewsManagerDelegate {
    func modelDidDeleteNewsFromDB(for id: String) {}
    
    func modelDidLoadNews(_ news: [News]) {
        let viewModels = news.map{ NewsModel(news: $0) }
        view?.updateView(viewModels)
    }
    
    func modelDidGetAnError(error: Error) {
        coordinator?.showAnError(error: error)
    }
}
