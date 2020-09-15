//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Артем  on 7/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        self.window?.rootViewController = UINavigationController(rootViewController: NewsCoordinator().createViewController())
        window?.makeKeyAndVisible()
    }
}

