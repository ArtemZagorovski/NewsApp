//
//  Interpreter.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class NewsController: NewsViewDelegate, ModelDelegate {
    
    private var model: NewsManager
    private var view: NewsView
    
    init (model: NewsManager, view: NewsView) {
        self.model = model
        self.view = view
    }
    
    func viewDidLoad() {
        view.animateActivity()
        model.loadNews()
    }
    
    func viewDidScrollTheEnd() {
        model.loadMoreNews()
    }
    
    func viewDidPullToRefresh() {
        model.refresh()
    }
    
    func viewDidChangeSearchTerm(_ term: String) {
        model.filter(for: term)
    }
    
    func viewDidTapFavouriteButton(for viewModel: [NewsViewModel]) {
        model.updateFavourite()
    }
    
    func modelDidLoadNews(_ news: [News]) {
        var viewModels: [NewsViewModel] = []
        news.forEach { news in
            guard let imageData = news.imageData, let image = UIImage(data: imageData) else { return }
            let viewModel = NewsViewModel(newsTitle: news.newsTitle,
                                          newsDescription: news.newsDescription,
                                          image: image,
                                          publishedAt: news.publishedAt,
                                          isFavourite: news.isFavourite)
            viewModels.append(viewModel)
        }
        view.updateView(viewModels)
    }
    
}
