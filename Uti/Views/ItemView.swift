//
//  ItemView.swift
//  Uti
//
//  Created by michellyes on 31/07/23.
//

import SwiftUI

struct ItemView: View {
    var body: some View {
        ZStack{
                   
           Circle()
               .frame(width: 65, height: 65)
               .foregroundColor(Color.gray.opacity(0.3))
           
           Image(systemName: "heart.fill")
                .foregroundColor(.color.darkRed)
                .font(.system(size: 28))
           
           ZStack(alignment: .bottomTrailing){
               RoundedRectangle(cornerRadius: 1)
                   .frame(width: 79, height:83)
                   .foregroundColor(Color.gray.opacity(0))
               
               Circle()
                   .frame(width: 65, height: 65)
                   .foregroundColor(Color.gray.opacity(0))
               
               ZStack(alignment: .center){
                           
                   RoundedRectangle(cornerRadius: 7.0, style: .continuous)
                       .frame(width: 30, height: 30)
                       .foregroundColor(.white)
                   
                   
                   HStack{
                       Text("1")
                           .foregroundColor(.color.darkRed)
                           .font(.system(size: 12))
                       Image(systemName: "drop.fill")
                           .foregroundColor(.color.darkRed)
                           .font(.system(size: 12))
                   }
                }
               

           }
           
       }
        
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView()
    }
}
