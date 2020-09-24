//
//  ServiceTests.swift
//  NewsAppTests
//
//  Created by Zagorovsky, Artem on 9/24/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import XCTest
@testable import NewsApp

final class ServiceTests: XCTestCase {
    private let apiService = APIService()
    
    func testLoadDataFromFirstPage() {
        let mockDelegate = loadData(page: 1)
        XCTAssertFalse(mockDelegate.news.isEmpty)
    }
    
    func testLoadDataFromZeroPage() {
        let mockDelegate = loadData(page: 0)
        XCTAssertTrue(mockDelegate.news.isEmpty)
    }
    
    func loadData(page: Int) -> MockApiServiceDelegate {
        let loadDataExpectation = expectation(description: "")
        let mockDelegate = MockApiServiceDelegate(expectation: loadDataExpectation)
        apiService.delegate = mockDelegate
        self.apiService.loadNews(page: page)
        waitForExpectations(timeout: 5, handler: nil)
        return mockDelegate
    }
}
