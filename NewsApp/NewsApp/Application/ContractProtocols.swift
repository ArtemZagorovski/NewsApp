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
    func viewDidTapFavButton(for viewModel: ViewmodelProtocol)
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

protocol ServiceGetable {
    func getData()
}

protocol LocalDataChangeble {
    func reloadData()
}

protocol DBDataLoaderDelegate {
    func localDataDidLoad(_ news: [News])
}

protocol APIServiceDelegate {
    func remoteDataDidLoad(_ news: [News])
}

