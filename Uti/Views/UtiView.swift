//
//  UtiView.swift
//  Uti
//
//  Created by jpbol on 26/06/2023.
//

import Foundation
import SwiftUI

struct UtiView: View {
    @State private var bouncing = true
    @State var showingSheet = false
    let uti: Uti
    
    var body: some View {
        VStack {
            VStack {
                Text("aa")
                    .bold()
                    .foregroundColor(.color.darkRed)
            }
            .padding(.horizontal, 4.0)
            .frame(width: 345, height: 110)
            .background(.white)
            .cornerRadius(20.0)
            
            Button("Kit de sobrevivencia uterina"){
                showingSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $showingSheet) {
                VStack{
                    SurvivalKitView()
                }
                .presentationDetents([.fraction(0.35)])
            }
            Image(changeImage(phase: uti.phase))
                .resizable()
                .scaledToFit()
                .frame(width: 330, height: 330)
                .foregroundColor(.accentColor)
                .offset(y: bouncing ? 30 : -30)
                .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: bouncing)
                .onAppear {
                    self.bouncing.toggle()
                }
        }
    }
    
    func changeText(phase: Phase) -> String {
        var text: String
        
        switch phase {
        case .menstrual:
            text = "Não to afim de sair hoje..."
        case .folicular:
            text = "Ô abestado é pra cliclar ali ó, ta vendo não?"
        case .fertile:
            text = "Qual o sextou de hoje?"
        case .luteal:
            text = "Hmmmm, to sentindo até meus chakras se alinhando de volta."
        case .pms:
            text = "OLHA, não me enche as trompas!!!!"
        }
        
        return text
    }
    
    func changeImage(phase: Phase) -> String {
        var image: String
        
        switch phase {
        case .menstrual:
            image = "CASEIRO_TRISTE"
        case .folicular:
            image = "FELIZ"
        case .fertile:
            image = "SAIDINHO_OCULOS"
        case .luteal:
            image = "BODYBUILDER"
        case .pms:
            image = "PUTO"
        }
        
        return image
    }
}
