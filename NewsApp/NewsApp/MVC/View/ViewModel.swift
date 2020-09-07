//
//  ViewModel.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/7/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

struct ViewModel {
    var newsTitle: String
    var newsDescription: String
    var image: UIImage
    var publishedAt: String?
    var isFavourite: Bool = false
}
