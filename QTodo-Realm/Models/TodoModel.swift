//
//  TodoModel.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 15.07.2023.
//

import Foundation
import RealmSwift

class TodoModel: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var desc: String
    @Persisted var isCompleted: Bool
    @Persisted var priority: Double
    @Persisted var creationTimestamp: Double
    @Persisted var dueDate: Date?
    
    override class func primaryKey() -> String? {
          return "id"
      }
    
}
