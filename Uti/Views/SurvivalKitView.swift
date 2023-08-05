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
            Text("Kit de Sobrevivência Uterina")
                .font(.system(size: 16))
                .fontWeight(.bold)
            
            HStack {
                SurvivalKitButton(category: Category.health, currentCategory: $currentCategory)
                SurvivalKitButton(category: Category.nutrition, currentCategory: $currentCategory)
                SurvivalKitButton(category: Category.leisure, currentCategory: $currentCategory)
            }
            
            LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(filteredItems) { item in
                    ItemView(item: item)
                }
            }
            .padding(.horizontal, 16)
            
        }
        .onChange(of: currentCategory) { newCategory in
            filteredItems = Item.getItems(category: newCategory)
        }
    }
}







