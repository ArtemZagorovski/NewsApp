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
    private var model: FavoriteNewsManager
    private let coordinator: FavoriteNewsCoordinator
    
    init(model: FavoriteNewsManager, view: NewsView, coordinator: FavoriteNewsCoordinator) {
        self.model = model
        self.view = view
        self.coordinator = coordinator
    }
}

extension FavoriteNewsController: NewsViewDelegate {
    var isFavoriteViewController: Bool {
        return true
    }
    
    func viewWillAppear() {
        model.delegate = self
        model.loadFavoriteNews()
    }
    
    func viewDidScrollToEnd() {}
    
    func viewDidPullToRefresh() {}
    
    func viewDidChangeSearchTerm(_ term: String) {
        model.filter(favorite: true, for: term)
    }
    
    func viewDidTapFavoriteButton(for viewModel: NewsViewModel, currentFavoriteState: Bool, updateCell: (Actions) -> ()) {
        model.updateFavorites(with: News(viewModel: viewModel), currentFavoriteState: currentFavoriteState, completion: updateCell)
    }
    
    func viewDidTapCell(for viewModel: NewsViewModel) {
        coordinator.showDetails(with: viewModel)
    }
}

extension FavoriteNewsController: NewsManagerDelegate {
    func modelDidLoadNews(_ news: [News]) {
        view?.updateView(news.map { NewsModel(news: $0) })
    }
    
    func modelDidGetAnError(error: Error) {
        coordinator.showAnError(error: error)
    }
}
