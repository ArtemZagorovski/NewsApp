//
//  FavouriteNewsContractProtocols.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/14/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

protocol FavouriteNewsViewDelegate: class {
    func viewDidLoad()
    func viewDidChangeSearchTerm(_ term: String)
    func viewDidTapFavouriteButton(for viewModel: NewsViewModel)
    func viewDidTapCell(for viewModel: NewsViewModel)
}

protocol FavouriteNewsView: class {
    func updateView(_ news: [NewsViewModel])
}

protocol FavouriteNewsManager {
    func loadNews()
    func filter(for text: String)
    func updateFavoutire()
}
