//
//  FavouriteNewsCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/15/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class FavouriteNewsCoordinator: DetailsShowable, ErrorShowable {
    private weak var view: UIViewController?
    private var dbService: LocalNewsService
    
    init(dbService: LocalNewsService) {
        self.dbService = dbService
    }
    
    func createViewController(model: FavoriteNewsManager) -> UIViewController {
        let view = NewsViewController()
        self.view = view
        let controller = FavouriteNewsController(model: model, view: view, coordinator: self)
        guard let model = model as? DefaultNewsManager else { return UIViewController() }
        view.delegate = controller
        dbService.delegate = model
        return view
    }
}
