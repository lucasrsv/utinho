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
    @State private var isSelected = false
    @State private var selectedItemOffset: CGSize = .zero
    @State private var utiPosition: [CGPoint]
    @State private var globalFrame: CGRect = .zero
    @Binding var isAnimationActive: Bool
    @State private var icons: [Icon] = []
    @Binding private var isExploding: Bool
    @State private var shouldDisappear = false
    @Binding var itemValue: String
    
    let item: Item
    
    init(utiPosition: [CGPoint], item: Item, isAnimationActive: Binding<Bool>, isExploding: Binding<Bool>, itemValue: Binding<String>) {
        self.utiPosition = utiPosition
        self.item = item
        self._isAnimationActive = isAnimationActive
        self._isExploding = isExploding
        self._itemValue = itemValue
    }
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 65, height: 65)
                .foregroundColor(isSelected ? .darkRed : Color.gray.opacity(0.15))
            Image(item.iconPath)
                .frame(width: 28, height: 28)
                .foregroundColor(.darkRed)
                .offset(selectedItemOffset)
                .zIndex(100)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isSelected = true
                           // UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            
                            selectedItemOffset = value.translation
                        }
                        .onEnded { value in
                            isSelected = false
                            let localTouchPoint = value.location
                            let globalTouchPoint = CGPoint(x: localTouchPoint.x + globalFrame.origin.x, y: localTouchPoint.y + globalFrame.origin.y)
                            
                            print("Local Touch Point (onEnded): \(localTouchPoint)")
                            print("Global Touch Point (onEnded): \(globalTouchPoint)")
                            print("Uti Postion: \(self.utiPosition)")
                            
                            if (globalTouchPoint.x >= utiPosition[0].x && globalTouchPoint.x <= utiPosition[1].x && globalTouchPoint.y >= utiPosition[0].y && globalTouchPoint.y <= utiPosition[1].y) {
                                itemValue = "\(utiStore.giveUtiItem(item: item))"
                                withAnimation {
                                    isExploding = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                        isExploding = false
                                    }
                                }
                            }
                            selectedItemOffset = .zero
                        }
                )
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
        .overlay(GlobalFrameReader(content: EmptyView(), globalFrame: $globalFrame))
    }
}

struct Icon: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let offset: CGSize
    let delay: Double
    let opacity: Double
    var shouldDisappear: Bool // Adicione a propriedade shouldDisappear
}

extension Color {
    static var random: Color {
        let colors = [Color.primaryOrange, Color.primaryYellow, Color.lightBlue, .white]
        return colors.randomElement() ?? .white
    }
}

//struct ItemView_Previews: PreviewProvider {
//    static func getUtiStore() -> UtiStore {
//        let utiStore: UtiStore = UtiStore()
//        utiStore.uti = Uti(currentCycleDay: 2, phase: .luteal, state: .sleepy, illness: .no, leisure: 50, health: 50, nutrition: 70, energy: 100, blood: 100, items: [])
//        return utiStore
//    }
//    static var previews: some View {
//        ItemView(utiPosition: [], item: Item.getItems(category: .health)[0])
//            .environmentObject(getUtiStore())
//    }
//}
