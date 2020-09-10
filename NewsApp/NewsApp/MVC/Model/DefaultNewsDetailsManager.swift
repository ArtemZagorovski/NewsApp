//
//  DefaultNewsDetailsDelegate.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/10/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

class DefaultNewsDetailsManager: NewsDetailsManager {
    
    var news: NewsViewModel?
    
    func updateFavourite(for viewModel: NewsViewModel) {
        print("Change on favourite")
    }
    
}
