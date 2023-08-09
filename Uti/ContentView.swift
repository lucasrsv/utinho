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
        
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        ZStack {
                            VStack() {
                                PhaseCycleCircle(uti: utiStore.uti)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            VStack {
                                StateBar(uti: utiStore.uti, category: .health)
                                StateBar(uti: utiStore.uti, category: .nutrition)
                                StateBar(uti: utiStore.uti, category: .leisure)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.bottom, 12)
                }
                UtiView()
                    .environmentObject(utiStore)
            
        }
        .padding(.all, 20)
        .background(
            Image("standard_background")
                .resizable()
                .ignoresSafeArea()
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static func getUtiStore() -> UtiStore {
        let utiStore: UtiStore = UtiStore()
        utiStore.uti = Uti(currentCycleDay: 2, phase: .luteal, state: .sleepy, illness: .no, leisure: 50, health: 50, nutrition: 70, energy: 100, blood: 100, items: [])
        return utiStore
    }
    
    static var previews: some View {
        ContentView()
            .environmentObject(getUtiStore())
    }
}
