//
//  ContentView.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 15.07.2023.
//

import SwiftUI
import RealmSwift

struct HomeScreen: View {
    
    @ObservedResults(CategoryModel.self) var categoryList
    @State private var isAddingCategorySheetActive: Bool = false
    
    var body: some View {
        VStack {
            if categoryList.isEmpty {
                Text("Empty List")
            } else {
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AddNewCategoryButton
            }
        }
        .sheet(isPresented: $isAddingCategorySheetActive) {
            AddCategoryView()
        }
        
    }
}

//MARK: - Subviews

extension HomeScreen {
    
    var AddNewCategoryButton: some View {
        
        Button {
            isAddingCategorySheetActive.toggle()
        } label: {
            Text("Add Category")
                .tint(.white)
                .padding()
                .background(Color.pink.opacity(0.8).ignoresSafeArea(edges: .bottom))
                .cornerRadius(12)
                .shadow(radius: 12)
                .padding()
        }

    }

}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
