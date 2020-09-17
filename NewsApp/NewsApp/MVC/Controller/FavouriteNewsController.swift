//
//  FavouriteNewsController.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/15/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class FavouriteNewsController {
    private weak var view: NewsView?
    private let model: NewsManager
    private let coordinator: FavouriteNewsCoordinator
    
    init(model: NewsManager, view: NewsView, coordinator: FavouriteNewsCoordinator) {
        self.view = view
        self.model = model
        self.coordinator = coordinator
    }
}

extension FavouriteNewsController: NewsViewDelegate {
    func viewDidLoad() {
        model.loadNews()
    }
    
    func viewDidScrollToEnd() {
        view?.stopAnimateActivity()
    }
    
    func viewDidPullToRefresh() {
        model.loadNews()
    }
    
    func viewDidChangeSearchTerm(_ term: String) {
        model.filter(for: term)
    }
    
    func viewDidTapFavouriteButton(for viewModel: NewsViewModel, closure: @escaping () -> ()) {
        model.addToFavorite(News(viewModel: viewModel), closure: closure)
    }
    
    func viewDidTapCell(for viewModel: NewsViewModel) {
        coordinator.showDetails(with: viewModel, view: view)
    }
}

extension FavouriteNewsController: NewsManagerDelegate {
    func modelDidLoadNews(_ news: [News]) {
        view?.updateView(news.map { NewsModel(news: $0) })
        if news.isEmpty {
            DispatchQueue.main.async {
                self.view?.showAnEmptyState()
            }
        }
    }
    
    func modelDidGetAnError(error: Error) {
        coordinator.showAnError(error: error, view: view)
    }
}
