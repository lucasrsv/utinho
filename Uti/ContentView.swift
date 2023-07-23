//
//  ContentView.swift
//  Uti
//
//  Created by lrsv on 12/06/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var utiStore: UtiStore
    @StateObject private var timerManager: TimerManager = TimerManager()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack {
                        StateBar(uti: $utiStore.uti, category: .health)
                        StateBar(uti: $utiStore.uti, category: .nutrition)
                        StateBar(uti: $utiStore.uti, category: .leisure)
                    }
                }
                Button("aumentar saude", action: increaseUtiHealth)
                Button ("diminuir saude", action: decreaseHealth)
                Button ("trocar estado do uti", action: changePhase)
                UtiView(uti: utiStore.uti)
            }
        }
        .onAppear {
            timerManager.setup(utiStore: utiStore)
        }
        .background(
            Image("standard_background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) //to be altered
        )
    }
    
    func changePhase(){
        utiStore.uti.phase = Phase.allCases.randomElement()!
        print (utiStore.uti.phase)
    }
    func increaseUtiHealth () {
        if (utiStore.uti.health + 10 > 100){
            utiStore.uti.health = 100
        }
        else {
            utiStore.uti.health += 10
        }
    }
    func decreaseHealth () {
        if (utiStore.uti.health - 10 < 0){
            utiStore.uti.health = 0
        }
        else {
            utiStore.uti.health -= 10
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
