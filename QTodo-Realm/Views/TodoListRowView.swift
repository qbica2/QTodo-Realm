//
//  TodoListRowView.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 16.07.2023.
//

import SwiftUI

struct TodoListRowView: View {
    
    @State private var isActive: Bool = false
    
    let todo: TodoModel
    
    var body: some View {
        HStack{
            Image(systemName: isActive ? "circle" : "circle.fill")
            Text(todo.title)
                .lineLimit(1)
            
            if let dueDate = todo.dueDate {
                Spacer()
                Text(formatDate(dueDate))
                    .foregroundColor(.gray)
            }
        }
        .font(.headline)
        .foregroundColor(.pink.opacity(0.8))
        .onTapGesture {
            withAnimation {
                isActive.toggle()
//                toggle todo
            }
        }
        .onAppear {
            isActive = !todo.isCompleted
        }
        
    }
}

//MARK: - Functions

extension TodoListRowView {
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
    
}

struct TodoListRowView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListRowView(todo: TodoModel())
    }
}
