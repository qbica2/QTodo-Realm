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
        VStack() {
            TitleLayer
            if categoryList.isEmpty {
                Spacer()
                EmptyListView(title: "You haven't created any categories yet.",
                              subtitle: "Tap to create your first category and start adding todos.")
                .onTapGesture {
                    isAddingCategorySheetActive = true
                }
                Spacer()
            } else {
                CategoryListView
            }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
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
    
    var CategoryListView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(categoryList, id: \.id) { item in
                    let viewModel = CategoryViewModel(category: item)
                    
                    NavigationLink(value: item) {
                        CategoryView(viewModel: viewModel)
                    }
                }
            }
            .navigationDestination(for: CategoryModel.self, destination: { item in
                TodoListScreen(category: item)
            })
            .padding()
        }
    }
    
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
    
    var TitleLayer: some View {
        Text("Welcome to QTodo")
            .font(.largeTitle)
            .foregroundColor(.pink)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
    }

}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeScreen()
        }
    }
}
