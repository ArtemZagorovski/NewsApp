//
//  ServiceProtocols.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/9/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

protocol NewsService {
    func getData(page: Int)
}

protocol RemoteNewsService: NewsService {
}

protocol LocalNewsService: NewsService {
    func saveData(_ news: News, closure: () -> ())
    func filter(for text: String)
}

protocol NewsRemoteServiceDelegate: class {
    func didLoadData(_ news: [[String : AnyObject]])
    func didGetAnError(error: Error)
}

protocol NewsLocalServiceDelegate: class {
    func didLoadData(_ news: [NewsEntity])
}
