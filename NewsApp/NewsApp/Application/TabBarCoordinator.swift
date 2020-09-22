//
//  TabBarCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/16/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class TabBarCoordinator {
    func createViewController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .blue
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        guard let listImage = UIImage(systemName: "list.bullet", withConfiguration: boldConfig),
        let favoriteImage = UIImage(systemName: "star", withConfiguration: boldConfig) else { return UITabBarController() }
        let model = DefaultNewsManager()
        let newsViewController = NewsCoordinator().createViewController(model: model)
        let favoriteNewsController = FavoriteNewsCoordinator().createViewController(model: model)
        
        tabBarController.viewControllers = [
            makeNavigationController(rootViewController: newsViewController, title: "News", image: listImage),
            makeNavigationController(rootViewController: favoriteNewsController, title: "Favorite", image: favoriteImage)
        ]
        
        return tabBarController
    }
    
    private func makeNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
