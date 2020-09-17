//
//  Logger.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/17/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class Logger {
    static let shared = Logger()
    private var loggedInfo = String()
    private init() {}
    
    func logError(error: Error) {
        loggedInfo.append("\n" + error.localizedDescription)
    }
    
    func getLog() -> String {
        return loggedInfo
    }
}
