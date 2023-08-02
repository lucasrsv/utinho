//
//  SurvivalKitButton.swift
//  Uti
//
//  Created by michellyes on 31/07/23.
//

import SwiftUI

struct SurvivalKitButton: View {
    
    let icon: String
    let title: String
    @Binding var selectedButton: String
    
    var body: some View {
        
        HStack{
            
            Button(action: {
                selectedButton = title
                print("Button touched")
            }, label: {
                HStack{
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundColor(selectedButton == title ? .white : .color.darkRed)
                    Text(title)
                        .font(.system(size: 14))
                        .foregroundColor(selectedButton == title ? .white : .color.darkRed)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 35)
                        .foregroundColor(selectedButton == title ? .color.darkRed : .white)
                        
                        
                )
            })
            
         
        }
    }
    
}
