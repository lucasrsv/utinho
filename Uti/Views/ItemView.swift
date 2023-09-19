//
//  ItemView.swift
//  Uti
//
//  Created by michellyes on 31/07/23.
//

import SwiftUI
import UIKit

struct ItemView: View {
    @EnvironmentObject private var utiStore: UtiStore
    //  @State private var isSelected = false
    @State private var selectedItemOffset: CGSize = .zero
    @State private var utiPosition: [CGPoint]
    let item: Item
    
    init(utiPosition: [CGPoint], item: Item) {
        self.utiPosition = utiPosition
        self.item = item
    }
    
    var body: some View {
        GeometryReader { geo in
            let globalFrame = geo.frame(in: .global)
            ZStack {
                Circle()
                    .frame(width: 65, height: 65)
                //.foregroundColor(isSelected ? .darkRed : Color.gray.opacity(0.15))
                Image(item.iconPath)
                    .frame(width: 28, height: 28)
                    .foregroundColor(.darkRed)
                    .offset(selectedItemOffset)
                    .zIndex(100)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                selectedItemOffset = value.translation
                            }
                            .onEnded { value in
                                let localTouchPoint = value.location
                                let globalTouchPoint = CGPoint(x: localTouchPoint.x + globalFrame.origin.x, y: localTouchPoint.y + globalFrame.origin.y)
                                
                                print("Local Touch Point (onEnded): \(localTouchPoint)")
                                print("Global Touch Point (onEnded): \(globalTouchPoint)")
                                print("Uti Postion: \(self.utiPosition)")

                                if (globalTouchPoint.x >= utiPosition[0].x && globalTouchPoint.x <= utiPosition[1].x && globalTouchPoint.y >= utiPosition[0].y && globalTouchPoint.y <= utiPosition[1].y){
                                    utiStore.giveUtiItem(item: item)
                                }
                                selectedItemOffset = .zero
                            }
                    )
                //                .onTapGesture {
                //                    utiStore.giveUtiItem(item: item)
                //                    isSelected.toggle()
                //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                //                        isSelected = false
                //                    }
                //                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                //                }
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 1)
                        .frame(width: 79, height:83)
                        .foregroundColor(Color.gray.opacity(0))
                    Circle()
                        .frame(width: 65, height: 65)
                        .foregroundColor(Color.gray.opacity(0))
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 7.0, style: .continuous)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                        HStack(spacing: 1) {
                            Image(systemName: "infinity")
                                .foregroundColor(.darkRed)
                                .font(.system(size: 10))
                            Image(systemName: "drop.fill")
                                .foregroundColor(.darkRed)
                                .font(.system(size: 10))
                        }
                        .frame(width: 30, height: 30)
                        .padding(4)
                    }
                }
            }
        }
        .zIndex(0)
    }
}
