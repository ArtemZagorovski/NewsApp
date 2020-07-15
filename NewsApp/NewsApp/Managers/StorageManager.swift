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
    static func saveTaskToDo(_ tasks: Task) {
        
        try! realm.write {
            realm.add(tasks)
        }
    }
    
    static func deliteTaskToDo (_ tasks: Task) {
        try! realm.write {
            realm.delete(tasks)
        }
    }
    
    static func saveGoal(_ goal: Goal) {
        
        try! realm.write {
            realm.add(goal)
        }
    }
    
    static func deliteGoal (_ goal: Goal) {
        try! realm.write {
            realm.delete(goal)
        }
    }
    
}
