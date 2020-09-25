//
//  Optional+or.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/25/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

extension Optional {
    func or(_ base: Wrapped) -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            return base
        }
    }
}
