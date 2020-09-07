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
        do {
            try realm.write {
                realm.add(news)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func deliteNews (_ news: News) {
        do {
            try realm.write {
                realm.delete(news)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func deleteAll () {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
