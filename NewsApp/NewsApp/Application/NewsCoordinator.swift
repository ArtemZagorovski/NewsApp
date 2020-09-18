//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/4/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

final class NewsCoordinator: DetailsShowable, ErrorShowable {
    private weak var view: UIViewController?
    private var apiService: RemoteNewsService
    private var dbService: LocalNewsService
    
    init(apiService: RemoteNewsService, dbService: LocalNewsService) {
        self.apiService = apiService
        self.dbService = dbService
    }
    
    func createViewController(model: NewsManager) -> UIViewController {
        let view = NewsViewController()
        self.view = view
        let controller = NewsController(model: model, view: view, coordinator: self)
        guard let model = model as? DefaultNewsManager else { return UIViewController() }
        view.delegate = controller
        apiService.delegate = model
        dbService.delegate = model
        return view
    }
}
