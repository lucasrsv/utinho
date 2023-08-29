//
//  StateBar.swift
//  Uti
//
//  Created by jpbol on 13/06/2023.
//

import Foundation
import SwiftUI

struct StateBar: View {
    let uti: Uti
    var category: Category
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .frame(width: 64.0, height: 28.0)
                .foregroundColor(.beige).opacity(0.42)
            
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .frame(width: (CGFloat(getCurrentValue())/100) * 64.0, height: 28.0)
                .foregroundColor(getCurrentValue() < 40 ? .blue : .lightBlue)
            
            HStack {
                defineIcon(category: category)
            }.frame(width: 64.0, height: 28.0)
        }
    }
    
    func defineIcon(category: Category) -> Image {
        switch category {
        case .health:
            return .images.healthIcon
        case .leisure:
            return .images.partyIcon
        case .nutrition:
            return .images.foodIcon
        }
    }
    
    func getCurrentValue() -> Double {
        switch category {
        case .health:
            return uti.health
        case .leisure:
            return uti.leisure
        case .nutrition:
            return uti.nutrition
        }
    }
}

    
    
//struct StateBar_Previews: PreviewProvider {
//    static var previews: some View {
//        StateBar(uti: Uti(currentCycleDay: 1, phase: .fertile, state: .bodybuilder, illness: .no, leisure: 100, health: 30, nutrition: 100, energy: 100, blood: 100, items: []), category: .health)
//    }
//}
