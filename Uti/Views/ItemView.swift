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
    @State private var isExploding = false
    @State private var shouldDisappear = false
    
    let item: Item
    
    init(utiPosition: [CGPoint], item: Item, isAnimationActive: Binding<Bool>) {
        self.utiPosition = utiPosition
        self.item = item
        self._isAnimationActive = isAnimationActive
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
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            
                            selectedItemOffset = value.translation
                        }
                        .onEnded { value in
                            isSelected = false
                            let localTouchPoint = value.location
                            let globalTouchPoint = CGPoint(x: localTouchPoint.x + globalFrame.origin.x, y: localTouchPoint.y + globalFrame.origin.y)
                            
                            print("Local Touch Point (onEnded): \(localTouchPoint)")
                            print("Global Touch Point (onEnded): \(globalTouchPoint)")
                            print("Uti Postion: \(self.utiPosition)")
                            
                            if (globalTouchPoint.x >= utiPosition[0].x && globalTouchPoint.x <= utiPosition[1].x && globalTouchPoint.y >= utiPosition[0].y && globalTouchPoint.y <= utiPosition[1].y){
                                utiStore.giveUtiItem(item: item)
                            }
                            selectedItemOffset = .zero
                            
                            isAnimationActive = true
                            
                            if isAnimationActive {
                                withAnimation {
                                    isExploding = true
                                    shouldDisappear = true // Ativar o desaparecimento
                                }
                                
                                // Após 1 segundo, redefina os ícones e desabilite o desaparecimento
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    withAnimation {
                                        icons = generateRandomIcons()
                                        shouldDisappear = false
                                        isExploding = false
                                    }
                                }
                            }
                            
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
    
    func generateRandomIcons() -> [Icon] {
        let iconNames = ["star.fill", "heart.fill", "circle.fill", "triangle.fill"]
        var newIcons: [Icon] = []
        
        for _ in 0..<10 {
            let iconName = iconNames.randomElement() ?? "star.fill"
            let color = Color.random
            let offset = CGSize(width: CGFloat.random(in: -100...100), height: CGFloat.random(in: -100...100))
            let delay = Double.random(in: 0...0.5)
            
            // Atribua true para shouldDisappear ao gerar ícones
            newIcons.append(Icon(name: iconName, color: color, offset: offset, delay: delay, shouldDisappear: true))
        }
        
        return newIcons
    }
    
}

struct Icon: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let offset: CGSize
    let delay: Double
    var shouldDisappear: Bool // Adicione a propriedade shouldDisappear
}

extension Color {
    static var random: Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
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
