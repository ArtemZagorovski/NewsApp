//
//  ServiceProtocols.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/9/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

protocol NewsService {
    func getData(date: String)
}

protocol RemoteNewsService: NewsService {
}

protocol LocalNewsService: NewsService {
    func saveData(_ news: [News])
    func removeData()
}

protocol NewsServiceDelegate: class {
    func didLoadData(_ news: [News])
    func didGetAnError(error: Error)
}
