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
//         handle saving todos
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(selectedCategory: CategoryModel())
    }
}
