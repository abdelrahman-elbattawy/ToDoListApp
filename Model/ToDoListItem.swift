//
//  ToDoListItem.swift
//  ToDoListApp
//
//  Created by Aboody on 14/08/2021.
//

import Foundation
import RealmSwift

class ToDoListItem: Object {
    
    static let realm = try! Realm()
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
}
