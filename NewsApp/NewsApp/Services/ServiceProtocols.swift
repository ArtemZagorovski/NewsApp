//
//  ServiceProtocols.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/9/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

protocol RemoteNewsService {
    func loadNews(page: Int)
    var delegate: NewsRemoteServiceDelegate? { get set }
}

protocol LocalNewsService {
    func loadNews()
    var delegate: NewsLocalServiceDelegate? { get set }
    func saveData(_ news: [News])
}

protocol NewsRemoteServiceDelegate: class {
    func didLoadData(_ news: [[String: AnyObject]])
    func didGetAnError(error: Error)
}

protocol NewsLocalServiceDelegate: class {
    func didLoadData(_ news: [NewsEntity])
}
