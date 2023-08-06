//
//  ItemView.swift
//  Uti
//
//  Created by michellyes on 31/07/23.
//

import SwiftUI
import UIKit

struct ItemView: View {
    
    @State private var isSelected = false
    let item: Item
    
    var body: some View {
        ZStack{
            
            Circle()
                .frame(width: 65, height: 65)
                .foregroundColor(isSelected ? .color.darkRed : Color.gray.opacity(0.3))
            
            Image(item.iconPath)
                .frame(width: 28, height: 28)
                .foregroundColor(.color.darkRed)
                .onTapGesture{
                    isSelected.toggle()
                    print("Clicou no item: \(item.name)")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                        isSelected = false
                    }
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
            
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
                    
                    HStack(spacing: 1) {
                        //Text("\(item.amount)")
                        Image(systemName: "infinity")
                                .foregroundColor(.color.darkRed)
                                .font(.system(size: 10))
                                
                            Image(systemName: "drop.fill")
                                .foregroundColor(.color.darkRed)
                                .font(.system(size: 10))
                        }
                        .frame(width: 30, height: 30)
                        .padding(4)
                }
            }
        }
    }
}
