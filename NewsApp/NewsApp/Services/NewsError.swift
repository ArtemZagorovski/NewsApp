//
//  NewsError.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/23/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

enum NewsError: Error {
    case parseDataError
    case wrongImageName
    case badInernetConnection
    case tooManyRequests
}

extension NewsError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parseDataError:
            return NSLocalizedString("Can't parse data from API", comment: "parse data error description")
        case .wrongImageName:
            return NSLocalizedString("Wrong image name", comment: "wrong image name error description")
        case .badInernetConnection:
            return NSLocalizedString("Bad internet connection", comment: "bad internet connection error description")
        case .tooManyRequests:
            return NSLocalizedString("To many requests, try to load news later", comment: "to many requests error description")
        }
    }
}
