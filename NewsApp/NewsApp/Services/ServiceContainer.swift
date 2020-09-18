//
//  ServiceContainer.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/16/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

struct ServiceContainer {
    let apiService = APIService()
    let dbService = DBDataLoader()
}
