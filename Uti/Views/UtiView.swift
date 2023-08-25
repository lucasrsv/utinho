//
//  UtiView.swift
//  Uti
//
//  Created by jpbol on 26/06/2023.
//

import Foundation
import SwiftUI

struct UtiView: View {
    @EnvironmentObject private var utiStore: UtiStore
    @State private var bouncing = true
    @State var showingSheet = false
    @State private var sheetHeight: CGFloat = .zero
    
    
    var body: some View {
        VStack {
            VStack {
                Text(LocalizedStringKey(getLocalizable(state:utiStore.uti.state)))
                    .bold()
                    .foregroundColor(.darkRed)
                    .padding(.horizontal, 8)
            }
            .padding(.horizontal, 4.0)
            .frame(minWidth: 330, idealWidth: 330, maxWidth: 330, minHeight: 80, idealHeight: 80, maxHeight: 100, alignment: .center)
            .background(.white)
            .cornerRadius(20.0)
            VStack {
                Image(changeImage(state: utiStore.uti.state))
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.accentColor)
                    .offset(y: bouncing ? 16 : -16)
                    .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: bouncing)
                    .onAppear {
                        withAnimation(nil) {
                            self.bouncing.toggle()
                        }
                    }
                Ellipse()
                    .foregroundColor(.strongRed)
                    .blur(radius: 20)
                    .frame(width: 150, height: 40)
                    .scaleEffect(bouncing ? 0.7: 1.0)
                    .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: bouncing)
            }
            
            Button("Kit de Sobrevivência Uterina") {
                showingSheet.toggle()
            }
            .frame(maxHeight: 100)
            .multilineTextAlignment(.center)
            .buttonStyle(CustomButtonStyle())
            .fontWeight(.medium)
            .sheet(isPresented: $showingSheet) {
                VStack{
                    SurvivalKitView()
                        .environmentObject(utiStore)
                }
                .edgesIgnoringSafeArea(.all)
                .presentationCornerRadius(32)
                .presentationBackground(.white)
                .overlay {
                    GeometryReader { geometry in
                        Color.clear.preference(key: SheetKitPreferenceKey.self, value: geometry.size.height)
                    }
                }
                .onPreferenceChange(SheetKitPreferenceKey.self) { newHeight in
                    sheetHeight = newHeight
                }
                .presentationDetents([.height(sheetHeight)])
            }
        }
    }
    
    func getLocalizable(state: UtiState) -> String {
        var localizable: String
        
        switch state {
        case .pissed:
            localizable = ["dialogue_pissed_1", "dialogue_pissed_2", "dialogue_pissed_3", "dialogue_pissed_4", "dialogue_pissed_4", "dialogue_pissed_6", "dialogue_pissed_7", "dialogue_pissed_8"].randomElement()!
        case .pissedHappy:
            localizable = ["dialogue_pissedHappy_1", "dialogue_pissedHappy_2", "dialogue_pissedHappy_3", "dialogue_pissedHappy_4", "dialogue_pissedHappy_5"].randomElement()!
        case .homelyHappy:
            localizable = ["dialogue_homelyHappy_1", "dialogue_homelyHappy_2", "dialogue_homelyHappy_3", "dialogue_homelyHappy_4", "dialogue_homelyHappy_5"].randomElement()!
        case .homelySad:
            localizable = ["dialogue_homelySad_1", "dialogue_homelySad_2", "dialogue_homelySad_3", "dialogue_homelySad_4"].randomElement()!
        case .sassyGlass:
            localizable = ["dialogue_sassyGlass_1", "dialogue_sassyGlass_2", "dialogue_sassyGlass_3", "dialogue_sassyGlass_4"].randomElement()!
        case .sassyTattoo:
            localizable = ["dialogue_sassyTattoo_1", "dialogue_sassyTattoo_2"].randomElement()!
        case .bodybuilder:
            localizable = ["dialogue_bodybuilder_1", "dialogue_bodybuilder_2", "dialogue_bodybuilder_3", "dialogue_bodybuilder_4", "dialogue_bodybuilder_5", "dialogue_bodybuilder_6"].randomElement()!
        case .happy:
            localizable = ["dialogue_happy_1", "dialogue_happy_2", "dialogue_happy_3", "dialogue_happy_4", "dialogue_happy_5"].randomElement()!
        case .sad:
            localizable = ["dialogue_sad_1", "dialogue_sad_2", "dialogue_sad_3", "dialogue_sad_4"].randomElement()!
        case .sickHpv:
            localizable = ""
        case .sickEndometriosis:
            localizable = ""
        case .hungry:
            localizable = ["dialogue_hungry_1", "dialogue_hungry_2", "dialogue_hungry_3", "dialogue_hungry_4", "dialogue_hungry_5", "dialogue_hungry_6", "dialogue_hungry_7"].randomElement()!
        case .sleepy:
            localizable = ["dialogue_sleepy_1", "dialogue_sleepy_2", "dialogue_sleepy_3", "dialogue_sleepy_4", "dialogue_sleepy_5"].randomElement()!
        }
        return localizable
    }
    
    func changeImage(state: UtiState) -> String {
        return state.rawValue
    }
    
    struct CustomButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 2) // Borda branca
                        .background(Color.clear) // Fundo transparente
                )
                .foregroundColor(.white)
                .accentColor(.white)
        }
    }
    
    struct SheetKitPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
    struct UtiView_Previews: PreviewProvider {
        static func getUtiStore() -> UtiStore {
            let utiStore: UtiStore = UtiStore()
            utiStore.uti = Uti(currentCycleDay: 2, phase: .luteal, state: .sleepy, illness: .no, leisure: 50, health: 50, nutrition: 70, energy: 100, blood: 100, items: [])
            return utiStore
        }
        static var previews: some View {
            UtiView()
                .environmentObject(getUtiStore())
        }
    }
}

