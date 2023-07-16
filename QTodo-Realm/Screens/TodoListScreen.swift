//
//  TodoListScreen.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 16.07.2023.
//

import SwiftUI
import RealmSwift

struct TodoListScreen: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedRealmObject var category: CategoryModel
    
    var body: some View {
        VStack {
            List {
                ForEach(category.todos, id: \.id) { todo in
                    TodoListRowView(todo: todo)
                        .swipeActions {
                            Button(role: .destructive) {
                                // Delete Todo
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                            
                            NavigationLink(value: todo) {
                                Image(systemName: "square.and.pencil")
                            }
                            .tint(.mint)
                        }
                }
            }
        }
        .navigationTitle(category.title)
        .navigationBarTitleDisplayMode(.large)
        .listStyle(.insetGrouped)
        .background(
            colorScheme == .light ? Color(UIColor.secondarySystemBackground) : .black
        )
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            AddTodoButton
        }
        .navigationDestination(for: TodoModel.self) { todo in
//                navigate to Todo detail
        }
        
    }
}

//MARK: - SubViews

extension TodoListScreen {
    
    var AddTodoButton: some View {
        
        Button {
            
        } label: {
            Image(systemName: "plus")
                .tint(.white)
                .padding()
                .background(Color.pink.opacity(0.8).ignoresSafeArea(edges: .bottom))
                .clipShape(Circle())
                .padding()
        }

    }
}

struct TodoListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TodoListScreen(category: CategoryModel())
    }
}
