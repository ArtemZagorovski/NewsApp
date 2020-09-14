//
//  CoreDataStack.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/11/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataStackDelegate: class {
    func didGetAnError(error: Error)
}

final class CoreDataStack {
    weak var delegate: CoreDataStackDelegate?
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "News")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                delegate?.didGetAnError(error: error)
            }
        }
        return container
    }()
}
