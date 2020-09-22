//
//  ContractProtocols.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/2/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

protocol NewsViewDelegate: class {
    func viewWillAppear()
    func viewDidScrollToEnd()
    func viewDidPullToRefresh()
    func viewDidChangeSearchTerm(_ term: String)
    func viewDidTapFavoriteButton(for viewModel: NewsViewModel, currentFavoriteState: Bool, refreshCell: @escaping () -> ())
    func viewDidTapCell(for viewModel: NewsViewModel)
    var isFavoriteViewController: Bool { get }
    func isNeedToRefreshCell() -> Bool
}

protocol NewsView: class {
    func updateView(_ news: [NewsViewModel])
    func animateActivity()
    func removeViewModel(for id: String)
}

protocol NewsManager {
    var delegate: NewsManagerDelegate? { get set }
    func loadNews()
    func refresh()
    func loadMoreNews()
    func filter(favorite: Bool, for text: String)
    func addToFavorites(news: News, refreshCell: @escaping () -> ())
    func removeFromFavorites(news: News, isFavoriteView: Bool, refreshCell: @escaping () -> ())
    func saveData()
}

protocol FavoriteNewsManager {
    var delegate: NewsManagerDelegate? { get set }
    func loadFavoriteNews()
    func saveData()
    func filter(favorite: Bool, for text: String)
    func addToFavorites(news: News, refreshCell: @escaping () -> ())
    func removeFromFavorites(news: News, isFavoriteView: Bool, refreshCell: @escaping () -> ())
}

protocol NewsManagerDelegate: class {
    func modelDidLoadNews(_ news: [News])
    func modelDidGetAnError(error: Error)
    func modelDidDeleteNewsFromDB(for id: String)
}

protocol NewsViewModel {
    var id: String { get }
    var newsTitle: String { get }
    var newsDescription: String { get }
    var image: UIImage? { get }
    var publishedAt: String? { get }
    var isFavorite: Bool { get set }
}
