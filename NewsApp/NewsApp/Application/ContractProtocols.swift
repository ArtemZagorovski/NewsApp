//
//  ContractProtocols.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/2/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

protocol ViewDelegate {
    func loadNews()
    func searchFor(text: String)
    func newFavouriteAdded()
}

protocol Viewable {
    func updateView(with: [News])
}

protocol NewsModel {
    func loadNews()
    func filterFor(text: String)
    func updateFavourite()
}

protocol ModelDelegate {
    func dataIsReady(with: [News])
}
