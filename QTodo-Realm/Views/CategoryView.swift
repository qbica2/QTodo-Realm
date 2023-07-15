//
//  CategoryView.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 15.07.2023.
//

import SwiftUI

struct CategoryView: View {
    
    let viewModel: CategoryViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(viewModel.background)
                .frame(height: 130)

            VStack(alignment: .trailing,spacing: 8) {
                Text(viewModel.category.title.capitalized)
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("\(viewModel.totalCount - viewModel.completedCount) \(viewModel.totalCount - viewModel.completedCount <= 1 ? "task" : "tasks") waiting")
                    .foregroundColor(.white)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("Total: \(viewModel.totalCount)")
                    .foregroundColor(.white)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)

                CategoryProgressView

            }
            .padding(12)
        }
        .padding()
        .frame(width: 200, height: 130)
    }
    
}

//MARK: - Subviews

extension CategoryView {
    
    var CategoryProgressView: some View {
        Circle()
            .trim(from: 0, to: CGFloat(viewModel.totalCount) / CGFloat(viewModel.completedCount))
            .stroke(Color.white, lineWidth: 6)
            .overlay(
                Circle()
                    .trim(from: CGFloat(viewModel.completedCount) / CGFloat(viewModel.totalCount), to: 1)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 6)
            )
            .frame(width: 26, height: 26)
            .rotationEffect(.degrees(-90))
    }
    
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(viewModel: CategoryViewModel(category: CategoryModel()))
    }
}
