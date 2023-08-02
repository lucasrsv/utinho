//
//  SurvivalKitView.swift
//  Uti
//
//  Created by michellyes on 31/07/23.
//

import SwiftUI

struct SurvivalKitView: View {
    @State private var selectedButton = "health"
    
    var body: some View {
        
        VStack{
            HStack{
                SurvivalKitButton(icon: "cross.fill", title: "health", selectedButton: $selectedButton)
                SurvivalKitButton(icon: "fork.knife", title: "nutrition", selectedButton: $selectedButton)
                SurvivalKitButton(icon: "party.popper.fill", title: "fun", selectedButton: $selectedButton)
            }
            
            VStack {
                ForEach(0..<2) { rowIndex in
                    HStack {
                        ForEach(0..<4) { _ in
                            ItemView()
                        }
                    }
                }
            }
            
            
        }
      
    }
}

