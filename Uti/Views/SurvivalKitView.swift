//
//  SurvivalKitView.swift
//  Uti
//
//  Created by michellyes on 31/07/23.
//

import SwiftUI

struct SurvivalKitView: View {
    @State private var currentCategory = Category.health
    @State private var filteredItems: [Item]
    
    init() {
        _filteredItems = State(initialValue: Item.getItems(category: .health))
    }

    var body: some View {
            VStack {
                HStack(spacing: 20) {
                    SurvivalKitButton(category: Category.health, currentCategory: $currentCategory)
                    SurvivalKitButton(category: Category.nutrition, currentCategory: $currentCategory)
                    SurvivalKitButton(category: Category.leisure, currentCategory: $currentCategory)
                }
                .padding(.bottom, 12)
                
                Divider()
                    .padding(.horizontal, 18) // Adiciona espaçamento nas laterais do Divider
                    .frame(height: 2)
                VStack{
                    HStack(spacing: 12) {
                        // Primeiro loop para exibir itens de 0 a 3 (índices 0, 1, 2 e 3)
                        ForEach(0..<min(4, filteredItems.count)) { index in
                            ItemView(item: filteredItems[index])
                        }
                    }
                    HStack(spacing: 12) {
                        // Segundo loop para exibir itens de 4 a 8 (índices 4, 5, 6, 7 e 8)
                        ForEach(4..<min(9, filteredItems.count)) { index in
                            ItemView(item: filteredItems[index])
                        }
                    }
                }
                .padding(.top, 12)
                
            }
            .ignoresSafeArea()
            .onChange(of: currentCategory) { newCategory in
                filteredItems = Item.getItems(category: newCategory)
        }
        
    }
}







