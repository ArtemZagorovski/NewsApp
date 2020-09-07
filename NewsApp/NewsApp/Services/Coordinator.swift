//
//  Interpreter.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class Coordinator: ViewDelegate, ModelDelegate {
    
    var model: NewsManager
    var view: View
    
    init (model: NewsManager, view: View) {
        self.model = model
        self.view = view
    }
    
    func viewDidLoad() {
        model.loadNews()
    }
    
    func viewDidScrollTheEnd() {
        model.loadNews()
    }
    
    func viewDidPullToRefresh() {
        model.loadNews()
    }
    
    func viewDidChangeSearchTerm(_ term: String) {
        model.filter(for: term)
    }
    
    func viewDidTapFavouriteButton(for viewModel: [ViewModel]) {
        model.updateFavourite()
    }
    
    func modelDidLoadNews(_ news: [News]) {
        var viewModels = [ViewModel]()
        news.forEach{ news in
            guard let imageData = news.imageData, let image = UIImage(data: imageData) else { return }
            let viewModel = ViewModel(newsTitle: news.newsTitle,
                                      newsDescription: news.newsDescription,
                                      image: image,
                                      publishedAt: news.publishedAt,
                                      isFavourite: news.isFavourite)
            viewModels.append(viewModel)
        }
        view.updateView(viewModels)
    }
    
}
