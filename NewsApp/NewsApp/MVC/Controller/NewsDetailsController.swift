//
//  NewsDetailsController.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/10/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

final class NewsDetailsController {
  private weak var view: NewsDetailsView?
  private var viewModel: NewsViewModel
  init (view: NewsDetailsView, viewModel: NewsViewModel) {
    self.view = view
    self.viewModel = viewModel
  }
}

extension NewsDetailsController: NewsDetailsViewDelegate {
  func viewDidLoad() {
    view?.updateView(viewModel)
  }
}
