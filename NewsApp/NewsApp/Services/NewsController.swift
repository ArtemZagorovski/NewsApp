//
//  Interpreter.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class NewsController {
    private var model: MainNewsDataProvider
    private weak var view: NewsView?
    private var coordinator: NewsCoordinator?
    
    init (model: MainNewsDataProvider, view: NewsView, coordinator: NewsCoordinator) {
        self.model = model
        self.view = view
        self.coordinator = coordinator
    }
}

extension NewsController: NewsViewDelegate {
    func isPullToRefreshAvailable() -> Bool {
        return true
    }
    
    func isLoadMoreDataAvailable() -> Bool {
        return true
    }
    
    func viewWillAppear() {
        model.delegate = self
        guard view?.viewModels.isEmpty == true else { return }
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
        view?.updateView(model.filter(favorite: false, for: term).map { NewsModel(news: $0) })
    }
    
    func viewDidTapFavoriteButton(for viewModel: NewsViewModel, currentFavoriteState: Bool, updateCell: (Actions) -> Void) {
        model.updateFavorites(with: News(viewModel: viewModel), currentFavoriteState: currentFavoriteState) {
            updateCell(.refresh)
        }
    }
    
    func viewDidTapCell(for viewModel: NewsViewModel) {
        coordinator?.showDetails(with: viewModel)
    }
}

extension NewsController: NewsManagerDelegate {
    func modelDidLoadNews() {
        let viewModels = model.news.map { NewsModel(news: $0) }
        view?.updateView(viewModels)
    }
    
    func modelDidGetAnError(error: Error) {
        coordinator?.showAnError(error: error)
    }
}
