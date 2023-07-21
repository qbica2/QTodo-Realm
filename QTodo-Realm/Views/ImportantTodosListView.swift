//
//  ImportantTodosListView.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 17.07.2023.
//

import SwiftUI
import RealmSwift

struct ImportantTodosListView: View {
    
    @ObservedObject var viewModel: ImportantTodosViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Important Todos in \(viewModel.category.title) category")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.sortedImportantTodos.prefix(3)) { todo in
                        NavigationLink(value: todo, label: {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.pink)
                                .frame(width: UIScreen.main.bounds.size.width - 80, height: 120)
                                .padding(.horizontal, 10)
                                .overlay(
                                    VStack(alignment: .leading, spacing: 20) {
                                        HStack {
                                            Text(todo.title)
                                                .font(.headline)
                                                .bold()
                                                .padding(.horizontal)
                                                .lineLimit(1)
                                            Spacer()
                                            Text("\(String(format: "%.0f", todo.priority))")
                                                .font(.title)
                                                .bold()
                                                .padding(.horizontal)
                                                .lineLimit(1)
                                        }
                                        
                                        HStack {
                                            
                                            Text(todo.desc)
                                                .font(.caption)
                                                .padding(.horizontal)
                                                .lineLimit(2)
                                            if let  dueDate = todo.dueDate {
                                                Spacer()
                                                
                                                Text(dueDate, style: .date)
                                                    .font(.caption)
                                                    .padding(.horizontal)
                                            }
                                            
                                        }
                                    }
                                        .foregroundColor(.white)
                                        .padding()
                            )
                        })
                    }
                    
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .background(
            colorScheme == .light ? .white : Color(UIColor.secondarySystemBackground)
        )
        .cornerRadius(15)
        .navigationDestination(for: TodoModel.self) { todo in
            TodoDetailScreen(todo: todo)
        }
    }
}


struct ImportantTodosListView_Previews: PreviewProvider {
    static var previews: some View {
        ImportantTodosListView(viewModel: ImportantTodosViewModel(category: CategoryModel()))
    }
}
