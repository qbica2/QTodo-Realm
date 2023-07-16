//
//  AddTodoView.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 16.07.2023.
//

import SwiftUI
import RealmSwift

struct AddTodoView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var csvm: CustomSheetViewModel
    @ObservedResults(CategoryModel.self) var categories
    @ObservedRealmObject var selectedCategory: CategoryModel

    @State private var todoTitle: String = ""
    @State private var todoDescription: String = ""
    @State private var isScheduled: Bool = false
    @State private var todoDueDate: Date = Date()
    @State private var priority: Double = 0
    
    let currentDate = Date()
    let oneMonthLater = Calendar.current.date(byAdding: .month, value: 1, to: Date())
    
    var body: some View {
        Form {
            TodoSection
            PrioritySection
            DueDateSection
            SaveButton
        }
        .formStyle(.grouped)
        .sheet(isPresented: $csvm.isCsActive) {
            CustomSheetView()
                .presentationDetents([.height(300)])
        }
    }
}

//MARK: - SubViews

extension AddTodoView {
    
    var TodoSection: some View {
        Section (content: {
            TextField("Title", text: $todoTitle)
            TextField("Description", text: $todoDescription)
        }, header: {
            Text("Todo")
        })
    }
    
    var PrioritySection: some View {
        Section {
            Slider(value: $priority,in: 0...100, step: 1) {
                Text("Priority")
            } minimumValueLabel: {
                Text("0")
                    .foregroundColor(.pink)
            } maximumValueLabel: {
                Text("\(String(format: "%.0f", priority))/100")
                    .foregroundColor(.pink)
            }
            .tint(.pink)
            
        } header: {
            Text("Priority")
        }
    }
    
    var DueDateSection: some View {
        Section {
            Toggle("Schedule Time", isOn: $isScheduled)
                .tint(.pink)
            DatePicker("Due Date", selection: $todoDueDate, in:currentDate...oneMonthLater! , displayedComponents: [.date])
                .disabled(!isScheduled)
                .tint(.pink)
        } header: {
            Text("Due Date")
        }
    }
    
    var SaveButton: some View {
        Button(action: saveButtonPressed ) {
            Text("Save")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 10)
                .background(Color.pink)
                .cornerRadius(10)
                .padding(.horizontal, 20)
        }
        .padding()
    }
    
}

//MARK: - Functions

extension AddTodoView {
    
    func saveButtonPressed(){
        let trimmedTitle = todoTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isTitleValid(title: trimmedTitle) {
            save(title: trimmedTitle)
            dismiss()
        }
    }
    
    func save(title: String){
        let newTodo = TodoModel()
        newTodo.title = title
        newTodo.desc = todoDescription
        newTodo.priority = priority
        newTodo.dueDate = isScheduled ? todoDueDate : nil
        newTodo.creationTimestamp = Date().timeIntervalSince1970
        newTodo.isCompleted = false
        
        $selectedCategory.todos.append(newTodo)
    }
    
    func isTitleValid(title: String) -> Bool {
        guard !title.isEmpty else {
            csvm.createErrorSheet(message: "Please enter a valid title!", emojis: "😱😨😰")
            return false
        }
        
        guard title.count >= 3 else {
            csvm.createErrorSheet(message: "Your new todo's title must be at least 3 characters long!", emojis: "😱😨😰")
            return false
        }
        
        return true
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(selectedCategory: CategoryModel())
    }
}
