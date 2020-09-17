//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/16/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class AppCoordinator {
    private let serviceContainer = ServiceContainer()
    
    func launch() -> UITabBarController {
        return TabBarCoordinator(serviceManager: serviceContainer.serviceManager).createViewController()
    }
}
