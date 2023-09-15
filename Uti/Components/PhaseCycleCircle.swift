//
//  PhaseCycleCircle.swift
//  Uti
//
//  Created by jpbol on 23/07/2023.
//

import Foundation
import SwiftUI

struct PhaseCycleCircle: View {
    let uti: Uti
    
    var body: some View {
        VStack (spacing: 12) {
            ZStack {
                Circle()
                    .strokeBorder(Color.beige, lineWidth: 12)
                    .frame(width: 84, height: 84)
                Circle()
                    .trim(from: 0, to: (CGFloat(uti.currentCycleDay)/28))
                    .stroke(
                        Color.lightBlue,
                        style: StrokeStyle (
                            lineWidth: 12
                        )
                    )
                    .padding(6)
                    .frame(width: 84, height: 84)
                    .rotationEffect(.degrees(-90))
                Text("\(uti.currentCycleDay)/28")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
            }
            Text(LocalizedStringKey(phaseText()))
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))
        }
    }
    
    func phaseText() -> String {
        switch (uti.phase) {
        case .menstrual:
            return "cycleTitle_menstural"
        case .fertile:
            return "cycleTitle_fertile"
        case .folicular:
            return "cycleTitle_folicular"
        case .luteal:
            return "cycleTitle_luteal"
        case .pms:
            return "cycleTitle_pms"
        }
    }
    
}

struct PhaseCycleCircle_Previews: PreviewProvider {
    static var previews: some View {
        PhaseCycleCircle(uti: Uti(currentCycleDay: 1, phase: .fertile, state: .bodybuilder, illness: .no, leisure: 100, health: 100, nutrition: 100, energy: 100, blood: 100, items: []))
    }
}
