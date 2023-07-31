//
//  SurvivalKitView.swift
//  Uti
//
//  Created by michellyes on 31/07/23.
//

import SwiftUI

struct SurvivalKitView: View {
    var body: some View {
        
        VStack{
            HStack{
                SurvivalKitButton(icon: "cross.fill", title: "health")
                SurvivalKitButton(icon: "fork.knife", title: "nutrition")
                SurvivalKitButton(icon: "party.popper.fill", title: "fun")
                
            }
            
            HStack{
                ItemView()
                ItemView()
                ItemView()
                
            }
            
            
        }
        
                
      
    }
}

struct SurvivalKitView_Previews: PreviewProvider {
    static var previews: some View {
        SurvivalKitView()
    }
}
