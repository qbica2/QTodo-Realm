//
//  NoCategoryView.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 17.07.2023.
//

import SwiftUI

struct EmptyListView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(.bottom, 8)
            
            Text(subtitle)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
        .foregroundColor(.pink)
        .padding()
        .background(
            (colorScheme == .light ? Color.white : Color.black)
                .cornerRadius(10)
                .shadow(color: colorScheme == .light ? Color.black : Color.white,radius: 10)
        )
    }
    
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView(title: "You haven't created any categories yet.",
                    subtitle: "Tap to create your first category and start adding todos.")
    }
}
