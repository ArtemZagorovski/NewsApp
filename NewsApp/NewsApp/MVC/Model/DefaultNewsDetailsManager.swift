//
//  DefaultNewsDetailsDelegate.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/10/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class DefaultNewsDetailsManager: NewsDetailsManager {
    weak var delegate: NewsDetailsManagerDelegate?
}
