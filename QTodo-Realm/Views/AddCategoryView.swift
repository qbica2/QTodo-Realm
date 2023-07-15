//
//  AddCategoryView.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 15.07.2023.
//

import SwiftUI
import RealmSwift

struct AddCategoryView: View {
        
    @ObservedResults(CategoryModel.self) var categoryList
    @EnvironmentObject var csvm: CustomSheetViewModel
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State private var title: String = ""
    @State private var categoryColor: Color = .pink
    
    var body: some View {
        ZStack {
            (colorScheme == .light ? Color.white : Color.black)
                .ignoresSafeArea()
            
            VStack {
                HeaderLayer
                TextfieldLayer
                ColorPickerLayer
                SaveButton
                Spacer()
            }
            .overlay(
                DismissButton
                , alignment: .topTrailing
            )
            .sheet(isPresented: $csvm.isCsActive) {
                CustomSheetView()
                    .presentationDetents([.height(300)])
            }
        }
    }
    
}

extension AddCategoryView {
    
    var HeaderLayer: some View {
        Text(title.capitalized)
            .font(.title2)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(categoryColor)
    }
    
    var TextfieldLayer: some View {
        TextField("Enter your category name", text: $title)
            .padding()
            .background(.secondary.opacity(0.5))
            .cornerRadius(10)
            .padding()
    }
    
    var ColorPickerLayer: some View {
        ColorPicker(selection: $categoryColor) {
            Text("Select a color for category")
                .foregroundColor(categoryColor)
                .font(.headline)
        }
        .padding()
        .background(
            (colorScheme == .light ? Color.white : Color.black)
                .cornerRadius(10)
                .shadow(color: colorScheme == .light ? Color.black : Color.white,radius: 10)
        )
        .padding(30)
    }
    
    var SaveButton: some View {
        Button {
            saveButtonPressed()
        } label: {
            Text("Save")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(.pink)
                .cornerRadius(12)
        }
    }
    
    var DismissButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "xmark.circle")
                .foregroundColor(.primary)
                .font(.title)
                .padding()
        }
            .frame(maxWidth: .infinity, alignment: .topTrailing)
    }
    
}

extension AddCategoryView {
    
    func save(title: String){
        let newCategory = CategoryModel()
        newCategory.title = title
        
        let color = UIColor(categoryColor).cgColor
        
        if let components = color.components {
            newCategory.red = Double(components[0])
            newCategory.green = Double(components[1])
            newCategory.blue = Double(components[2])
            newCategory.opacity = Double(components[3])
        }
        $categoryList.append(newCategory)
    }
    
    func saveButtonPressed(){
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isTitleValid(title: trimmedTitle) {
            save(title: trimmedTitle)
            dismiss()
        }
    }
    
    func isTitleValid(title: String) -> Bool {
        
        guard !title.isEmpty else {
            csvm.createErrorSheet(message: "Please enter a valid title!", emojis: "😱😨😰")
            return false
        }
        
        guard title.count >= 3 else {
            csvm.createErrorSheet(message: "Your new category's title must be at least 3 characters long!", emojis: "😱😨😰")
            return false
        }
        
        return true
    }
    
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
            .environmentObject(CustomSheetViewModel())
    }
}
