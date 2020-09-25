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
    private let mockDBService = MockDBService()

    func testNumberStringFilter() {
        XCTAssertTrue(testFilter(newsIds: ["1", "2", "3"], testText: "1", expected: ["1"]))
    }
    
    func testLetterStringFilter() {
        XCTAssertTrue(testFilter(newsIds: ["a", "b", "c"], testText: "c", expected: ["c"]))
    }
    
    func testOneLetterFromStringFilterAllMembers() {
        XCTAssertTrue(testFilter(newsIds: ["Vitali", "Artem", "Slavik"], testText: "a", expected: ["Vitali", "Artem", "Slavik"]))
    }
    
    func testOneLetterFromStringFilterTwoMembers() {
        XCTAssertTrue(testFilter(newsIds: ["Vitali", "Artem", "Slavik"], testText: "i", expected: ["Vitali", "Slavik"]))
    }
    
    func testOneLetterFromStringFilterDifferentRegister() {
        XCTAssertTrue(testFilter(newsIds: ["Vitali", "Artem", "Slavik"], testText: "v", expected: ["Vitali", "Slavik"]))
    }
    
    func testSomeLetterFromStringFilter() {
        XCTAssertTrue(testFilter(newsIds: ["Vitali", "Vilat", "Zhan"], testText: "vi", expected: ["Vitali", "Vilat"]))
    }
    
    func testEmptyStringFilter() {
        XCTAssertTrue(testFilter(newsIds: ["Vitali", "Vilat", "Zhan"], testText: "", expected: ["Vitali", "Vilat", "Zhan"]))
    }
    
    func testSpaceFilter() {
        XCTAssertTrue(testFilter(newsIds: ["Vitali", "Vilat", "Zhan"], testText: " ", expected: []))
    }
    
    func testFilter(newsIds: [String], testText: String, expected: [String]) -> Bool {
        let ids = newsIds
        let apiService = MockApiService(newsArray: ids.map { makeNews(with: $0) })
        let filterExpectation = expectation(description: "")
        let mockDelegate = MockDelegate(expectation: filterExpectation)
        
        let text = testText
        let model = DefaultNewsManager(apiService: apiService, dbService: mockDBService)
        model.loadNews()
        model.delegate = mockDelegate
        model.filter(favorite: false, for: text)
        waitForExpectations(timeout: 1, handler: nil)
        return expected == mockDelegate.news.map { $0.newsTitle }
    }
    
    private func makeNews(with id: String) -> [String: AnyObject] {
        let anyId = id as AnyObject
        return  [
            "author": anyId,
            "title": anyId,
            "description": anyId,
            "url": anyId,
            "publishedAt": anyId
        ]
    }
}
