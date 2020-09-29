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
    func viewWasDeinited() {
        model.saveData()
    }
    
    func isPullToRefreshAvailable() -> Bool {
        return true
    }
    
    func isLoadMoreDataAvailable() -> Bool {
        return true
    }
    
    func viewWillAppear() {
        model.delegate = self
        if view?.viewModels.isEmpty == true {
            view?.animateActivity()
            model.loadNews()
        } else {
            let news = model.news(onlyFavorite: false, filter: nil)
            view?.updateView(news.map { NewsModel(news: $0) })
        }
    }
    
    func viewDidScrollToEnd() {
        model.loadNews()
    }
    
    func viewDidPullToRefresh() {
        view?.updateView([])
        model.refresh()
    }
    
    func viewDidChangeSearchTerm(_ term: String) {
        let filtredNews = model.news(onlyFavorite: false, filter: term)
        view?.updateView(filtredNews.map { NewsModel(news: $0) })
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
        let viewModels = model.news(onlyFavorite: false, filter: nil).map { NewsModel(news: $0) }
        guard let viewModelsFromView = view?.viewModels else { return }
        view?.updateView(viewModelsFromView + viewModels)
    }
    
    func modelDidGetAnError(error: Error) {
        DispatchQueue.main.async {
            self.coordinator?.showAnError(error: error)
        }
    }
}
