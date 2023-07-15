//
//  CategoryViewModel.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 15.07.2023.
//

import Foundation
import SwiftUI

class CategoryViewModel: ObservableObject {
        
    @Published var category: CategoryModel
    
    init(category: CategoryModel) {
        self.category = category
    }
    
    var background: Color {
        return Color(
            red: category.red,
            green: category.green,
            blue: category.blue,
            opacity: category.opacity
        )
    }
    
    var completedCount: Int {
        return category.todos.filter { $0.isCompleted }.count
    }
    
    var totalCount: Int {
        return category.todos.count
    }
}
