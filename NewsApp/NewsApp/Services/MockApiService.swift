//
//  MocApiService.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/24/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
@testable import NewsApp

final class MockApiService: RemoteNewsService {
    var delegate: NewsRemoteServiceDelegate?
    var newsData: [[String: AnyObject]]
    
    init(newsArray: [[String: AnyObject]]) {
        newsData = newsArray
    }
    func loadNews(page: Int) {
        delegate?.didLoadData(newsData)
    }
}
