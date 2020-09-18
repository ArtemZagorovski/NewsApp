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
    func viewWillAppear() {
        view?.animateActivity()
        model.delegate = self
        model.loadNews()
    }
    
    func viewWillDisappear() {
        model.saveData()
    }
    
    func viewDidScrollToEnd() {
        model.loadMoreNews()
    }
    
    func viewDidPullToRefresh() {
        model.refresh()
    }
    
    func viewDidChangeSearchTerm(_ term: String) {
        model.filterAllNews(for: term)
    }
    
    func viewDidTapFavouriteButton(for viewModel: NewsViewModel, refreshCell: @escaping () -> ()) {
        model.updateFavorites(with: News(viewModel: viewModel), refreshCell: refreshCell)
    }
    
    func viewDidTapCell(for viewModel: NewsViewModel) {
        guard let view = view as? UIViewController else { return }
        coordinator?.showDetails(with: viewModel, view: view)
    }
}

extension NewsController: NewsManagerDelegate {
    func modelDidLoadFavoriteNews(_ news: [News]) {
        
    }
    
    func modelDidLoadNews(_ news: [News]) {
        let viewModels = news.map{ NewsModel(news: $0) }
        view?.updateView(viewModels)
    }
    
    func modelDidGetAnError(error: Error) {
        guard let view = view as? UIViewController else { return }
        coordinator?.showAnError(error: error, view: view)
    }
}
