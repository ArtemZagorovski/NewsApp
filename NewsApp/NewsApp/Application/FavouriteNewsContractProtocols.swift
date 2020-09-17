//
//  FavouriteNewsContractProtocols.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/14/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

protocol FavoriteNewsViewDelegate: class {
    func favoriteViewDidLoad()
    func favoriteViewDidPullToRefresh()
    func favoriteViewDidChangeSearchTerm(_ term: String)
    func favoriteViewDidTapFavouriteButton(for viewModel: NewsViewModel, closure: @escaping () -> ())
    func favoriteViewDidTapCell(for viewModel: NewsViewModel)
}

protocol FavoriteNewsView: class {
    func updateFavoriteView(_ news: [NewsViewModel])
}

protocol FavoriteNewsManager {
    func loadFavoriteNews()
    func filterFavorite(for text: String)
    func addToFavorite(_ news: News, closure: @escaping () -> ())
}

protocol FavoriteNewsManagerDelegate: class {
    func favoriteModelDidLoadNews(_ news: [News])
    func favoriteModelDidGetAnError(error: Error)
}
