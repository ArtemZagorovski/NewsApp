//
//  FavouriteNewsController.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/15/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class FavoriteNewsController {
    private weak var view: NewsView?
    private var model: FavoriteNewsDataProvider
    private let coordinator: FavoriteNewsCoordinator
    
    init(model: FavoriteNewsDataProvider, view: NewsView, coordinator: FavoriteNewsCoordinator) {
        self.model = model
        self.view = view
        self.coordinator = coordinator
    }
}

extension FavoriteNewsController: NewsViewDelegate {
    func isPullToRefreshAvailable() -> Bool {
        return false
    }
    
    func isLoadMoreDataAvailable() -> Bool {
        return false
    }
    
    func viewWillAppear() {
        model.delegate = self
        model.loadFavoriteNews()
    }
    
    func viewDidScrollToEnd() {}
    
    func viewDidPullToRefresh() {}
    
    func viewDidChangeSearchTerm(_ term: String) {
        view?.updateView(model.filter(favorite: true, for: term).map { NewsModel(news: $0) })
    }
    
    func viewDidTapFavoriteButton(for viewModel: NewsViewModel, currentFavoriteState: Bool, updateCell: (Actions) -> Void) {
        model.updateFavorites(with: News(viewModel: viewModel), currentFavoriteState: currentFavoriteState, completion: updateCell)
    }
    
    func viewDidTapCell(for viewModel: NewsViewModel) {
        coordinator.showDetails(with: viewModel)
    }
}

extension FavoriteNewsController: NewsManagerDelegate {
    func modelDidLoadNews() {
        view?.updateView(model.newsFromDB.map { NewsModel(news: $0) })
    }
    
    func modelDidGetAnError(error: Error) {
        coordinator.showAnError(error: error)
    }
}
