//
//  NewsEntity+initFromNewsModel.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/15/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

extension News {
    convenience init(viewModel: NewsViewModel) {
        self.init(
            id: viewModel.id,
            newsTitle: viewModel.newsTitle,
            newsDescription: viewModel.newsDescription,
            imageData: viewModel.image?.pngData(),
            publishedAt: viewModel.publishedAt,
            isFavorite: viewModel.isFavorite)
    }
}
