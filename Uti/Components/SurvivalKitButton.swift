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
    @State var isSelected = false
    
    var body: some View {
        
        HStack{
            
            Button(action: {
                isSelected.toggle()
                print("Rounded Button")
            }, label: {
                HStack{
                    Image(systemName: icon)
                        .foregroundColor(isSelected ? .white : .color.darkRed)
                    Text(title)
                        .foregroundColor(isSelected ? .white : .color.darkRed)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(isSelected ? .color.darkRed : .white)
                        
                )
            })
            
            
            
            
            
            
        }
    }
    
    struct SurvivalKitButton_Previews: PreviewProvider {
        static var previews: some View {
            SurvivalKitButton(icon: "cross.fill", title: "health")
        }
    }
}
