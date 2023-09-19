//
//  SurvivalKitView.swift
//  Uti
//
//  Created by michellyes on 31/07/23.
//

import SwiftUI

struct SurvivalKitView: View {
    @EnvironmentObject private var utiStore: UtiStore
    @State private var currentCategory = Category.health
    @State private var filteredItems: [Item]
    @State private var utiPosition: [CGPoint]
    
    init(utiPosition: [CGPoint]) {
        self.utiPosition = utiPosition
        _filteredItems = State(initialValue: Item.getItems(category: .health))
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 20) {
                SurvivalKitButton(category: Category.health, currentCategory: $currentCategory)
                SurvivalKitButton(category: Category.nutrition, currentCategory: $currentCategory)
                SurvivalKitButton(category: Category.leisure, currentCategory: $currentCategory)
            }
            .padding(.top, 24)
            .padding(.bottom, 12)
            Divider()
                .padding(.horizontal, 18) // Adiciona espaçamento nas laterais do Divider
                .frame(height: 2)
            VStack {
                HStack(spacing: 12) {
                    // Primeiro loop para exibir itens de 0 a 3 (índices 0, 1, 2 e 3)
                    ForEach(0..<min(4, filteredItems.count)) { index in
                        ItemView(utiPosition: utiPosition, item: filteredItems[index])
                            .environmentObject(utiStore)
                    }
                }
                HStack(spacing: 12) {
                    // Segundo loop para exibir itens de 4 a 8 (índices 4, 5, 6, 7 e 8)
                    ForEach(4..<min(9, filteredItems.count)) { index in
                        ItemView(utiPosition: utiPosition, item: filteredItems[index])
                            .environmentObject(utiStore)
                    }
                }
            }
            .ignoresSafeArea()
            .onChange(of: currentCategory) { newCategory in
                filteredItems = Item.getItems(category: newCategory)
            }
            
        }
    }
}
