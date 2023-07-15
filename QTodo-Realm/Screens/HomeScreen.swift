//
//  ContentView.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 15.07.2023.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
