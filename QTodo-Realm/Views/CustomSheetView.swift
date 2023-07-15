//
//  CustomSheetView.swift
//  QTodo-Realm
//
//  Created by Mehmet Kubilay Akdemir on 15.07.2023.
//

import SwiftUI

struct CustomSheetView: View {
    
    @EnvironmentObject var csvm: CustomSheetViewModel
    
    var body: some View {
        ZStack {
            
            csvm.csType == .error ?
                Color.pink.opacity(0.8)
                    .ignoresSafeArea() :
                Color.green.opacity(0.8)
                    .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Image(systemName: csvm.csType == .error ? "x.circle" : "checkmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                Group{
                    Text(csvm.csMessage)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    Text(csvm.csEmojis)
                }
                .fontWeight(.semibold)
                .font(.title2)
                
            }
            .padding(.horizontal, 20)
        }
    }
}

struct CustomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSheetView()
    }
}
