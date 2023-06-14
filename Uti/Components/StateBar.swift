//
//  StateBar.swift
//  Uti
//
//  Created by jpbol on 13/06/2023.
//

import Foundation
import SwiftUI

struct StateBar: View {
    
    @Binding var uti: Uti
    var image: Image
    
    var body: some View {
        ZStack (alignment: .leading){
            RoundedRectangle(cornerRadius: 8.13, style: .continuous)
                .frame(width: 63.0, height: 28.0)
                .foregroundColor(.color.bege).opacity(0.42)
            
            RoundedRectangle(cornerRadius: 8.13, style: .continuous)
                .frame(width: (CGFloat(uti.health)/100) * 63.0, height: 28.0)
                .foregroundColor(uti.health < 40 ? .color.darkLightBlue : .color.lightBlue)
                      
            HStack {
                image
            }.frame(width: 63.0, height: 28.0)
        }
        
    }
}
