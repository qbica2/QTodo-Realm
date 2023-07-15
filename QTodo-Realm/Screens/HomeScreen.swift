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
    }
}

//MARK: - Subviews

extension HomeScreen {
    
    var AddNewCategoryButton: some View {
        
        Button {
            
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
