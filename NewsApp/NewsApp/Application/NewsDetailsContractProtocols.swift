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
}

protocol NewsDetailsViewDelegate: class {
    func viewDidLoad()
}

protocol NewsDetailsManager {
}

protocol NewsDetailsManagerDelegate: class {
    func modelDidGetAnError(error: Error)
}
