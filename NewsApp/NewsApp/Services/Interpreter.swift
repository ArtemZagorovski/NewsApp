//
//  Interpreter.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

class Interpreter: ViewDelegate, ModelDelegate {
    
    var model: NewsManager
    var view: View
    
    init (model: NewsManager, view: View) {
        self.model = model
        self.view = view
    }
    
    func viewDidLoad() {
        model.loadNews()
    }
    
    func viewDidChangeSearchTerm(_ term: String, isSearchBarEmpty: Bool) {
        model.filter(for: term, isSearchBarEmpty: isSearchBarEmpty)
    }
    
    func viewDidTapFavouriteButton(for viewModel: ViewModel) {
        model.updateFavourite()
    }
    
    func modelDidLoadNews(_ news: [News]) {
        view.updateView(with: news)
    }
    
}
