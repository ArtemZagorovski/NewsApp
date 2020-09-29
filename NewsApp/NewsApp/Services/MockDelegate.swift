//
//  MokDelegate.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/24/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import XCTest
@testable import NewsApp

final class MockDelegate: NewsManagerDelegate {
    private(set) var news: [News] = []
    private let expectation: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    func modelDidLoadNews() {
        expectation.fulfill()
    }
    
    func modelDidGetAnError(error: Error) {
        Logger.shared.logError(error: error)
    }
}
