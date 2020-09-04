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
    func viewDidTapFavouriteButton(for viewModel: ViewModel)
}

protocol View {
    func updateView(with: [ViewModel])
}

protocol NewsManager {
    func loadNews()
    func filter(for text: String)
    func updateFavourite()
}

protocol ModelDelegate {
    func modelDidLoadNews(_ news: [News])
}

protocol DataLoader {
    func getData()
}

protocol DataManagerDelegate {
    func dataManagerDidLoadData(_ news: [News])
}

protocol LocalDataChanger {
    func saveData(_ news: [News])
    func removeData()
}

protocol DataLoaderDelegate {
    func didLoadData(_ news: [News])
}

