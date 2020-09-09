//
//  ServiceProtocols.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/9/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

protocol RemoteNewsService: NewsServiceCoordinator {
}

protocol LocalNewsService: NewsServiceCoordinator {
    func saveData(_ news: [News])
    func removeData()
}

protocol NewsServiceDelegate: class {
    func didLoadData(_ news: [News])
    func didGetTotalNews(total: Int)
    func didGetAnError(error: Error)
}
