//
//  URLCreator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/10/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class URLCreator {
    private let scheme = "http"
    private let host = "newsapi.org"
    private let path = "/v2/everything"
    private let q = "Apple"
    private let sortBy = "popular"
    private let language = "en"
    private let apiKey = "6a2f2df98b7d4086a3aa0b9877d333a9"
    
    func createUrl(with page: Int) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "sortBy", value: sortBy),
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        return components.url
    }
}
