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
    func viewWillDisappear()
    func viewDidScrollToEnd()
    func viewDidPullToRefresh()
    func viewDidChangeSearchTerm(_ term: String)
    func viewDidTapFavouriteButton(for viewModel: NewsViewModel, refreshCell: @escaping () -> ())
    func viewDidTapCell(for viewModel: NewsViewModel)
}

protocol NewsView: class {
    func updateView(_ news: [NewsViewModel])
    func animateActivity()
    func stopAnimateActivity()
    func changeVisibilityOfAnEmptyState()
}

protocol NewsManager {
    var delegate: NewsManagerDelegate? { get set }
    func loadNews()
    func refresh()
    func loadMoreNews()
    func filterAllNews(for text: String)
    func updateFavorites(with news: News, refreshCell: @escaping () -> ())
    func saveData()
}

protocol FavoriteNewsManager {
    var delegate: NewsManagerDelegate? { get set }
    func loadFavoriteNews()
    func saveData()
    func filterFavoriteNews(for text: String)
    func updateFavorites(with news: News, refreshCell: @escaping () -> ())
}

protocol NewsManagerDelegate: class {
    func modelDidLoadNews(_ news: [News])
    func modelDidLoadFavoriteNews(_ news: [News])
    func modelDidGetAnError(error: Error)
}

protocol NewsViewModel {
    var id: String { get }
    var newsTitle: String { get }
    var newsDescription: String { get }
    var image: UIImage? { get }
    var publishedAt: String? { get }
    var isFavourite: Bool { get set }
}
