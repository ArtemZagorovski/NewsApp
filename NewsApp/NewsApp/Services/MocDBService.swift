//
//  MocDBService.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/24/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class MockBDService: LocalNewsService {
    var delegate: NewsLocalServiceDelegate?
    private var store: [NewsEntity] = []
    
    func loadNews() {
        delegate?.didLoadData(store)
    }
    
    func saveData(_ news: [News]) {
        print("Save to db")
    }
}
