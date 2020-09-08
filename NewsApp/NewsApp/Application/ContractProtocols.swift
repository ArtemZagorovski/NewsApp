//
//  ContractProtocols.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/2/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

protocol ViewDelegate: class {
    func viewDidLoad()
    func viewDidScrollTheEnd()
    func viewDidPullToRefresh()
    func viewDidChangeSearchTerm(_ term: String)
    func viewDidTapFavouriteButton(for viewModel: [NewsViewModel])
}

protocol View {
    func updateView(_ news: [NewsViewModel])
    func animateActivity()
}

protocol NewsManager {
    func loadNews()
    func refresh()
    func loadMoreNews()
    func filter(for text: String)
    func updateFavourite()
}

protocol ModelDelegate: class {
    func modelDidLoadNews(_ news: [News])
}

protocol DataLoader {
    func getData()
}

protocol DataManagerDelegate: class {
    func dataManagerDidLoadData(_ news: [News])
}

protocol LocalDataChanger {
    func saveData(_ news: [News])
    func removeData()
}

protocol DataLoaderDelegate: class {
    func didLoadData(_ news: [News])
}

protocol ViewModel {
    var newsTitle: String { get set }
    var newsDescription: String { get set }
    var image: UIImage { get set }
    var publishedAt: String? { get set }
    var isFavourite: Bool { get set }
}
