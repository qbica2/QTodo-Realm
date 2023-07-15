//
//  CustomSheetViewModel.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 15.07.2023.
//

import Foundation

enum CustomSheetType {
    case error
    case success
}

class CustomSheetViewModel: ObservableObject {
    
    @Published var isCsActive: Bool = false
    @Published var csType: CustomSheetType = .error
    @Published var csMessage: String = ""
    @Published var csEmojis: String = ""
    
    func createSuccesSheet(message: String, emojis: String){
        csType = .success
        csMessage = message
        csEmojis = emojis
        isCsActive = true
    }
    
    func createErrorSheet(message: String, emojis: String) {
        csType = .error
        csMessage = message
        csEmojis = emojis
        isCsActive = true
    }
}
