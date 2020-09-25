//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Zagorovsky, Artem on 9/24/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import XCTest
@testable import NewsApp

final class NewsManagerTests: XCTestCase {
    private let mokApiService = MockApiService()
    private let mokDBService = MockDBService()
    private var model: DefaultNewsManager?
    
    override func setUp() {
        model = DefaultNewsManager(apiService: mokApiService, dbService: mokDBService)
        mokApiService.delegate = model
    }

    func testDefaultFilterData() {
        XCTAssertTrue(filterNewsWith(text: "Bitcoin"))
    }
    
    func testWhitespaceFilterData() {
        XCTAssertTrue(filterNewsWith(text: " "))
    }
    
    func testIncorrectInputFilterData() {
        XCTAssertTrue(filterNewsWith(text: "ABC123"))
    }
    
    private func filterNewsWith(text: String) -> Bool {
        let filterExpectation = expectation(description: "")
        let mockDelegate = MockDelegate(expectation: filterExpectation)
        model?.loadNews()
        model?.delegate = mockDelegate
        model?.filter(favorite: false, for: text)
        waitForExpectations(timeout: 5, handler: nil)
        let filtredArray = mockDelegate.news.filter { $0.newsTitle.lowercased().contains(text.lowercased()) ||
            $0.newsDescription.lowercased().contains(text.lowercased()) }
        return filtredArray == mockDelegate.news
    }
}
