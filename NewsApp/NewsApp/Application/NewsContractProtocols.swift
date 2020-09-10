//
//  ContractProtocols.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/2/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

protocol NewsViewDelegate: class {
    func viewDidLoad()
    func viewDidScrollToEnd()
    func viewDidPullToRefresh()
    func viewDidChangeSearchTerm(_ term: String)
    func viewDidTapFavouriteButton(for viewModel: [NewsViewModel])
    func viewDidTapCell(for viewModel: NewsViewModel)
}

protocol NewsView {
    func updateView(_ news: [NewsViewModel])
    func animateActivity()
    func showAnError(error: Error)
}

protocol NewsManager {
    func loadNews()
    func refresh()
    func loadMoreNews()
    func filter(for text: String)
    func updateFavourite()
}

protocol NewsManagerDelegate: class {
    func modelDidLoadNews(_ news: [News])
    func modelDidGetAnError(error: Error)
}

protocol NewsViewModel {
    var newsTitle: String { get }
    var newsDescription: String { get }
    var image: UIImage? { get }
    var publishedAt: String? { get }
    var isFavourite: Bool { get }
}
