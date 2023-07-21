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
    @State private var isAddingTodoSheetActive = false
    
    var body: some View {
        VStack {
            
            ImportantTodosListView(viewModel: ImportantTodosViewModel(category: category))
            
            List {
                ForEach(category.todos, id: \.id) { todo in
                    TodoListRowView(todo: todo)
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteTodo(todo: todo)
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
        .sheet(isPresented: $isAddingTodoSheetActive, content: {
            AddTodoView(selectedCategory: category)
        })
        .navigationDestination(for: TodoModel.self) { todo in
            TodoDetailScreen(todo: todo)
        }
        
    }
}

//MARK: - SubViews

extension TodoListScreen {
    
    var AddTodoButton: some View {
        
        Button {
            isAddingTodoSheetActive.toggle()
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

//MARK: - Functions

extension TodoListScreen {
    
    func deleteTodo(todo: TodoModel){
        if let index = category.todos.firstIndex(where: { $0.id == todo.id }) {
            $category.todos.remove(at: index)
        }
    }
    
}

struct TodoListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TodoListScreen(category: CategoryModel())
    }
}
