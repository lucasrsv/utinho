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
    let buttonTitle: String
    let buttonSize: ButtonSize
    let action: () -> Void
    
    var body: some View {
        
        Button(action: {
            action()
        }, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.darkRed)
                Text(buttonTitle)
                    .foregroundColor(.white)
                    .font(.system(size: buttonSize == .large ? 28 : 14))
                    .fontWeight(FontWeight.bold.value)
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
