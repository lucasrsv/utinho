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
    @State private var sheetHeight: CGFloat = .zero
    @Binding var showingSheet: Bool
    @State private var isAnimationActive = false
    
    init(utiPosition: [CGPoint], showingSheet: Binding<Bool>) {
        self.utiPosition = utiPosition
        self._showingSheet = showingSheet
        self._filteredItems = State(initialValue: Item.getItems(category: .health))
    }
    
    var body: some View {
        ZStack {
            VStack() {
                Spacer()
                ZStack {
                    Text("survivalKit_title")
                        .foregroundColor(.darkRed)
                        .font(.system(size: 20, weight: .semibold))
                    HStack {
                        Spacer()
                        Button(action: {
                            showingSheet.toggle()
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: FontSize.h3.rawValue, weight: FontWeight.semibold.value))
                                .foregroundColor(.darkRed)
                                .padding(.trailing, Spacing.xlarge)
                        }
                    }
                }
                .padding(.top, Spacing.medium)
                HStack(alignment: .center, spacing: 20) {
                    SurvivalKitButton(category: Category.health, currentCategory: $currentCategory)
                    SurvivalKitButton(category: Category.nutrition, currentCategory: $currentCategory)
                    SurvivalKitButton(category: Category.leisure, currentCategory: $currentCategory)
                }
                .padding(.top, Spacing.xxsmall)
                .padding(.bottom, 12)
                Divider()
                    .padding(.horizontal, 18)
                    .frame(height: 2)
                VStack {
                    HStack(spacing: 12) {
                        ForEach(0..<min(4, filteredItems.count)) { index in
                            ItemView(utiPosition: utiPosition, item: filteredItems[index], isAnimationActive: $isAnimationActive)
                                .environmentObject(utiStore)
                        }
                    }
                    HStack(spacing: 12) {
                        ForEach(4..<min(9, filteredItems.count)) { index in
                            ItemView(utiPosition: utiPosition, item: filteredItems[index], isAnimationActive: $isAnimationActive)

                                .environmentObject(utiStore)
                        }
                    }
                }
                .padding(.bottom, Spacing.medium)
                .onChange(of: currentCategory) { newCategory in
                    filteredItems = Item.getItems(category: newCategory)
                }
            }
            .padding(.bottom, sheetHeight)
            .background(
                VStack {
                    Spacer()
                    LinearGradient(colors: [.white], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(maxHeight: 312)
                        .roundedCorner(24, corners: [.topLeft, .topRight])
                }
            )
        }
        .frame(maxHeight: .infinity)
    }
}

struct SurvivalKitView_Previews: PreviewProvider {
    @State static var showingSheet = true
    static func getUtiStore() -> UtiStore {
        let utiStore: UtiStore = UtiStore()
        utiStore.uti = Uti(currentCycleDay: 2, phase: .luteal, state: .sleepy, illness: .no, leisure: 50, health: 50, nutrition: 70, energy: 100, blood: 100, items: [])
        return utiStore
    }
    
    static var previews: some View {
        SurvivalKitView(utiPosition: [], showingSheet: $showingSheet)
            .environmentObject(getUtiStore())
    }
}

struct InternalSheetKitPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
