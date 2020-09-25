//
//  MockDBService.swift
//  NewsAppTests
//
//  Created by Zagorovsky, Artem on 9/25/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
@testable import NewsApp

final class MockDBService: LocalNewsService {
    var delegate: NewsLocalServiceDelegate?
    
    func loadNews() {}
    
    func saveData(_ news: [News]) {}
}
