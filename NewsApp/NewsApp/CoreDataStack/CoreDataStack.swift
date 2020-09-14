//
//  CoreDataStack.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/11/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "News")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        }
        return container
    }()
}
