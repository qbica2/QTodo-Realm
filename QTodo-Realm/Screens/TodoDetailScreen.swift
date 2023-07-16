//
//  TodoDetailScreen.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 16.07.2023.
//

import SwiftUI
import RealmSwift

struct TodoDetailScreen: View {
    
    @ObservedRealmObject var todo: TodoModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var isActive: Bool = false
    @State private var dueDate: Date = Date()
    @State private var isScheduled: Bool = false
    @State private var priority: Double = 80
    
    let currentDate = Date()
    let oneMonthLater = Calendar.current.date(byAdding: .month, value: 1, to: Date())

    
    var body: some View {
        
        VStack {
            Form {
                TitleSection
                DescriptionSection
                StatusSection
                PrioritySection
                DueDateSection
            }
            SaveButton
        }
        .navigationBarTitle("Edit Todo ✏️")
        .onAppear(perform: updateUI)
    }
}

//MARK: - SubViews

extension TodoDetailScreen {
    
    var TitleSection: some View {
        Section (content: {
            TextField(todo.title, text: $title)
                .foregroundColor(.pink)
        }, header: {
            Text("Change Title")
        })
    }
    
    var DescriptionSection: some View {
        Section (content: {
            TextField(todo.desc, text: $description)
                .foregroundColor(.pink)
        }, header: {
            Text("Change Description")
        })
    }
    
    var StatusSection: some View {
        Section {
            Toggle(isActive ? "Active" : "Passive" , isOn: $isActive)
                .tint(.pink)
        } header: {
            Text("Change Status")
        }
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
            Text("Change Priority")
        }
    }
    
    var DueDateSection: some View {
        Section {
            Toggle("Schedule Time", isOn: $isScheduled)
                .tint(.pink)
            DatePicker("Due Date", selection: $dueDate, in:currentDate...oneMonthLater! , displayedComponents: [.date])
                .disabled(!isScheduled)
                .tint(.pink)
        } header: {
            Text("Change Due Date")
        }
    }
    
    var SaveButton: some View {
        Button(action: saveButtonPressed) {
            Text("Save")
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                .padding(.vertical, 8)
                .background(Color.pink.opacity(0.8))
                .clipShape(Capsule())
        }
    }
}

//MARK: - Functions

extension TodoDetailScreen {
    
    func updateUI(){
        title = todo.title
        description = todo.desc
        priority = todo.priority
        isActive = !todo.isCompleted
        if todo.dueDate != nil {
            isScheduled = true
            dueDate = todo.dueDate ?? Date()
        }
    }
    
    func saveButtonPressed(){
        
    }
    
}

struct TodoDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TodoDetailScreen(todo: TodoModel())
        }
    }
}
