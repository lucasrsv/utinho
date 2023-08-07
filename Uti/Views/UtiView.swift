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
    let uti: Uti
    
    var body: some View {
        VStack {
            VStack {
                Text(changeText(phase:uti.phase))
                    .bold()
                    .foregroundColor(.darkRed)
            }
            .padding(.horizontal, 4.0)
                .frame(width: 345, height: 110)
                .background(.white)
                .cornerRadius(20.0)
            VStack{
                Image(changeImage(state: UtiState.sleepy))
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.accentColor)
                    .offset(y: bouncing ? 30 : -30)
                    .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: bouncing)
                    .onAppear {
                        self.bouncing.toggle()
                    }
                Ellipse()
                    .foregroundColor(.strongRed)
                    .blur(radius: 20)
                    .frame(width: 150, height: 40)
                    .scaleEffect(bouncing ? 0.7: 1.0)
                    .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: bouncing)
            }
        }
    }
    
    func changeText(phase: Phase) -> String {
        var text: String
        
        switch phase {
        case .menstrual:
            text = "Não to afim de sair hoje..."
        case .folicular:
            text = "Ô abestado é pra clicar ali ó, ta vendo não?"
        case .fertile:
            text = "Qual o sextou de hoje?"
        case .luteal:
            text = "Hmmmm, to sentindo até meus chakras se alinhando de volta."
        case .pms:
            text = "OLHA, não me enche as trompas!!!!"
        }
        
        return text
    }
    
    func changeImage(state: UtiState) -> String {
        return state.rawValue
    }
}

struct UtiView_Previews: PreviewProvider {
    static var previews: some View {
        UtiView(uti: Uti(currentCycleDay: 1, phase: .fertile, state: .bodybuilder, illness: .no, leisure: 100, health: 100, nutrition: 100, energy: 100, blood: 100, items: []))
    }
}
