//
//  StorageManager.swift
//  YOUCAN
//
//  Created by Артем  on 3/30/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveNews(_ news: News) {
        
        try! realm.write {
            realm.add(news)
        }
    }
    
    static func deliteNews (_ news: News) {
        try! realm.write {
            realm.delete(news)
        }
    }
    
}
