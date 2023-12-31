//
//  QTodo_RealmApp.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 15.07.2023.
//

import SwiftUI

@main
struct QTodo_RealmApp: App {
    
    @StateObject var csvm = CustomSheetViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeScreen()
            }
            .environmentObject(csvm)
        }
    }
}
