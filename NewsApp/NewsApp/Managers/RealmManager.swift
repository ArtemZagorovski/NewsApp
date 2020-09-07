//
//  StorageManager.swift
//  NewsApp
//
//  Created by Артем  on 7/15/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class RealmManager {
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
    
    static func deleteAll () {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
