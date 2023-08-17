//
//  PopUpButton.swift
//  Uti
//
//  Created by michellyes on 17/08/23.
//

import SwiftUI

enum ButtonSize {
    case small
    case large
}

struct PopUpButton: View {
    let buttonSize: ButtonSize
    var body: some View {
        
        Button(action: {
            
        }, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.darkRed)
                Text("Ok, entendi!")
                    .foregroundColor(.white)
                    .font(.system(size: buttonSize == .large ? 28 : 14))
            }
            .frame(width: buttonSize == .large ? 256 : 128, height: buttonSize == .large ? 72 : 36)
        })
    }
    
}

//struct PopUpButton_Previews: PreviewProvider {
//    static var previews: some View {
//        PopUpButton()
//    }
//}
