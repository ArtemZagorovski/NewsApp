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
    func viewDidTapFavoriteButton(for viewModel: NewsViewModel, currentFavoriteState: Bool, updateCell: (Actions) -> Void)
    func viewDidTapCell(for viewModel: NewsViewModel)
    func isPullToRefreshAvailable() -> Bool
    func isLoadMoreDataAvailable() -> Bool
}

protocol NewsView: class {
    var viewModels: [NewsViewModel] { get }
    func updateView(_ news: [NewsViewModel])
    func animateActivity()
}

protocol NewsDataProvider {
    var delegate: NewsManagerDelegate? { get set }
    func filter(favorite: Bool, for text: String)
    func updateFavorites(with news: News, currentFavoriteState: Bool, completion: (Actions) -> Void)
    func saveData()
}

protocol MainNewsDataProvider: NewsDataProvider {
    func loadNews()
    func refresh()
    func loadMoreNews()
}

protocol FavoriteNewsDataProvider: NewsDataProvider {
    func loadFavoriteNews()
}

protocol NewsManagerDelegate: class {
    func modelDidLoadNews(_ news: [News])
    func modelDidGetAnError(error: Error)
}

protocol NewsViewModel {
    var id: String { get }
    var newsTitle: String { get }
    var newsDescription: String { get }
    var image: UIImage? { get }
    var publishedAt: String? { get }
    var isFavorite: Bool { get set }
}
