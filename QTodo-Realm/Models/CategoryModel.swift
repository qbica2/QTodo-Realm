//
//  CategoryModel.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 15.07.2023.
//

import Foundation
import RealmSwift

class CategoryModel: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var red: Double
    @Persisted var green: Double
    @Persisted var blue: Double
    @Persisted var opacity: Double
    @Persisted var todos = List<TodoModel>()
    
    override class func primaryKey() -> String? {
          return "id"
      }
    
}
