//
//  TabBarCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/16/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class TabBarCoordinator {
    private let apiService: RemoteNewsService
    private let dbService: LocalNewsService
    
    init(apiService: RemoteNewsService, dbService: LocalNewsService) {
        self.apiService = apiService
        self.dbService = dbService
    }
    
    func createViewController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .blue
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        guard let listImage = UIImage(systemName: "list.bullet", withConfiguration: boldConfig),
        let favouriteImage = UIImage(systemName: "star", withConfiguration: boldConfig) else { return UITabBarController() }
        let model = DefaultNewsManager(apiService: apiService, dbService: dbService)
        let newsViewController = NewsCoordinator(apiService: apiService, dbService: dbService).createViewController(model: model)
        let favouriteNewsController = FavouriteNewsCoordinator(dbService: dbService).createViewController(model: model)
        
        tabBarController.viewControllers = [
            generateNavigationController(rootViewController: newsViewController, title: "News", image: listImage),
            generateNavigationController(rootViewController: favouriteNewsController, title: "Favourite", image: favouriteImage)
        ]
        
        return tabBarController
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
