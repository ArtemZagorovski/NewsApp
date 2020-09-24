//
//  Constants.swift
//  NewsApp
//
//  Created by Pavel Sakhanko on 16.07.20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

struct Constants {
  struct NewsTable {
    static let newsCellID = "newsCellID"
  }
  struct AppColors {
    static let white = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
  }
  struct Logic {
    static var countOfDays = 0
    static var totalNews = 140
  }
  struct SystemWords {
    static let news = "News"
    static let searchNews = "Search news"
    static let defaultImageName = "news"
    static let flameImageName = "flame"
    static let fillFlameImageName = "flame.fill"
    static let textShowMore = "...show more"
  }
  struct NotificationNames {
    static let newData = "newDataNotification"
  }
}
