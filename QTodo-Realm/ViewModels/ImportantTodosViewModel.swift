//
//  ImportantTodosViewModel.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 18.07.2023.
//

import Foundation

class ImportantTodosViewModel: ObservableObject {
    
    @Published var category: CategoryModel
    
    init(category: CategoryModel) {
        self.category = category
    }
    
    var sortedImportantTodos: [TodoModel] {
        return Array(category.todos).filter { !$0.isCompleted }.sorted { $0.priority > $1.priority }
    }

}
