//
//  FavouriteNewsController.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/15/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class FavouriteNewsController {
    private weak var view: NewsView?
    private var model: FavoriteNewsManager
    private let coordinator: FavouriteNewsCoordinator
    
    init(model: FavoriteNewsManager, view: NewsView, coordinator: FavouriteNewsCoordinator) {
        self.model = model
        self.view = view
        self.coordinator = coordinator
    }
}

extension FavouriteNewsController: NewsViewDelegate {
    func viewWillAppear() {
        model.delegate = self
        model.loadFavoriteNews()
    }
    
    func viewDidScrollToEnd() {
        view?.stopAnimateActivity()
    }
    
    func viewDidPullToRefresh() {
        view?.stopAnimateActivity()
    }
    
    func viewDidChangeSearchTerm(_ term: String) {
        model.filterFavoriteNews(for: term)
    }
    
    func viewDidTapFavouriteButton(for viewModel: NewsViewModel, refreshCell: @escaping () -> ()) {
        model.updateFavorites(with: News(viewModel: viewModel), refreshCell: refreshCell)
    }
    
    func viewDidTapCell(for viewModel: NewsViewModel) {
        guard let view = view as? UIViewController else { return }
        coordinator.showDetails(with: viewModel, view: view)
    }
}

extension FavouriteNewsController: NewsManagerDelegate {
    func modelDidLoadNews(_ news: [News]) {
        view?.updateView(news.map { NewsModel(news: $0) })
        self.view?.changeVisibilityOfAnEmptyState()
    }
    
    func modelDidGetAnError(error: Error) {
        guard let view = view as? UIViewController else { return }
        coordinator.showAnError(error: error, view: view)
    }
}
