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
    func isPullToRefreshAvaliable() -> Bool {
        return false
    }
    
    func isLoadMoreDataAvailable() -> Bool {
        return false
    }
    
    func viewWillAppear() {
        model.delegate = self
        model.loadFavoriteNews()
    }
    
    func viewDidScrollToEnd() {
        
    }
    
    func viewDidPullToRefresh() {
        
    }
    
    func viewDidChangeSearchTerm(_ term: String) {
        model.filter(favorite: true, for: term)
    }
    
    func viewDidTapFavouriteButton(for viewModel: NewsViewModel, isFavorite: Bool, refreshCell: @escaping () -> ()) {
        model.updateFavorites(with: News(viewModel: viewModel), isFavorite: isFavorite, refreshCell: refreshCell)
    }
    
    func viewDidTapCell(for viewModel: NewsViewModel) {
        coordinator.showDetails(with: viewModel)
    }
}

extension FavouriteNewsController: NewsManagerDelegate {
    func modelDidLoadNews(_ news: [News]) {
        view?.updateView(news.map { NewsModel(news: $0) })
    }
    
    func modelDidGetAnError(error: Error) {
        coordinator.showAnError(error: error)
    }
}
