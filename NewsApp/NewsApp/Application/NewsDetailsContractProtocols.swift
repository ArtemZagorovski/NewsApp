//
//  NewsDetailsContractProtocols.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/10/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

protocol NewsDetailsView {
    func updateView(_ news: NewsViewModel)
    func showAnError(error: Error)
}

protocol NewsDetailsViewDelegate: class {
    func viewDidLoad()
    func viewDidTapFavouriteButton(for viewModel: NewsViewModel)
}

protocol NewsDetailsManager {
    func updateFavourite(for viewModel: NewsViewModel)
}

protocol NewsDetailsManagerDelegate: class {
    func modelDidGetAnError(error: Error)
}
