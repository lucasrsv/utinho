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
        VStack {
            StateBar(uti: $uti, category: .health)
            StateBar(uti: $uti, category: .nutrition)
            StateBar(uti: $uti, category: .leisure)
            Button("aumentar saude", action: increaseUtiHealth)
            Button ("diminuir saude", action: decreaseHealth)
        }
        .padding()
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
