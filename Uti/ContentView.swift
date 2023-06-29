//
//  ContentView.swift
//  Uti
//
//  Created by lrsv on 12/06/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var uti: Uti

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack {
                        StateBar(uti: $uti, category: .health)
                        StateBar(uti: $uti, category: .nutrition)
                        StateBar(uti: $uti, category: .leisure)
                    }
                    Spacer()
                }
                Button("aumentar saude", action: increaseUtiHealth)
                Button ("diminuir saude", action: decreaseHealth)
                Button ("trocar estado do uti", action: changePhase)
                UtiView(uti: uti)
            }
        }
        .background(
            Image("standard_background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) //to be altered
        )
    }
    func changePhase(){
        uti.phase = Phase.allCases.randomElement()!
        print (uti.phase)
    }
    func increaseUtiHealth () {
        if (uti.health + 10 > 100){
            uti.health = 100
        }
        else {
            uti.health += 10
        }
    }
    func decreaseHealth () {
        if (uti.health - 10 < 0){
            uti.health = 0
        }
        else {
            uti.health -= 10
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
