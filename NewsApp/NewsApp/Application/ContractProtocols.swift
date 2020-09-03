//
//  ContractProtocols.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/2/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

protocol ViewDelegate {
    func viewDidLoad()
    func viewDidChangeSearchTerm(_ term: String)
    func viewDidTapFavButton(for viewModel: Type)
}

protocol Viewable {
    func updateView(with: [ViewmodelProtocol])
}

protocol NewsModel {
    func loadNews()
    func filter(for text: String)
    func updateFavourite()
}

protocol ModelDelegate {
    func modelDidLoadNews(_ news: [News])
}
