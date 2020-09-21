//
//  FavouriteNewsCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/15/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class FavouriteNewsCoordinator: DetailsShowable, ErrorShowable {
    weak var viewController: UIViewController?
    
    func createViewController(model: FavoriteNewsManager) -> UIViewController {
        let viewController = NewsViewController()
        self.viewController = viewController
        let controller = FavouriteNewsController(model: model, view: viewController, coordinator: self)
        viewController.delegate = controller
        return viewController
    }
}
