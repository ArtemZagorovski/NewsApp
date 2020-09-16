//
//  TabBarCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/16/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class TabBarCoordinator {
    private let newsViewController: UIViewController
    private let favouriteNewsController: UIViewController
    private let serviceContainer: ServiceContainer?
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
        self.newsViewController = NewsCoordinator(serviceContainer: serviceContainer).createViewController()
        self.favouriteNewsController = FavouriteNewsCoordinator(serviceContainer: serviceContainer).createViewController()
    }
    
    func createViewController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        guard let listImage = UIImage(systemName: "list.bullet", withConfiguration: boldConfig),
        let favouriteImage = UIImage(systemName: "star", withConfiguration: boldConfig) else { return UITabBarController() }
        
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
