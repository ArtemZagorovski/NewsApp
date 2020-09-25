//
//  MokServiceDelegate.swift
//  NewsAppTests
//
//  Created by Zagorovsky, Artem on 9/24/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import XCTest
@testable import NewsApp

final class MockApiServiceDelegate: NewsRemoteServiceDelegate {
    var news: [[String : AnyObject]] = []
    private let expectation: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    func didLoadData(_ news: [[String : AnyObject]]) {
        self.news = news
        expectation.fulfill()
    }
    
    func didGetAnError(error: Error) {
        print(error.localizedDescription)
    }
}
