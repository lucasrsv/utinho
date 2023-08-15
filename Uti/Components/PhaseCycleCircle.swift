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
    @State private var isPopoverPresented = false
    
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
            Text(phaseText())
                .foregroundColor(.darkRed)
                .font(.system(size: 14, weight: .semibold))
                .onTapGesture {
                                isPopoverPresented.toggle()
                            }
                            .popover(isPresented: $isPopoverPresented, arrowEdge: .top) {
                                CycleChangePopupView()
                                    
                            }
        }
    }
    
    func phaseText() -> String {
        switch (uti.phase) {
        case .menstrual:
            return "FASE MENSTRUAL"
        case .fertile:
            return "FASE FÉRTIL"
        case .folicular:
            return "FASE FOLICULAR"
        case .luteal:
            return "FASE LÚTEA"
        case .pms:
            return "TPM"
        }
    }
    
}

struct PhaseCycleCircle_Previews: PreviewProvider {
    static var previews: some View {
        PhaseCycleCircle(uti: Uti(currentCycleDay: 1, phase: .fertile, state: .bodybuilder, illness: .no, leisure: 100, health: 100, nutrition: 100, energy: 100, blood: 100, items: []))
    }
}
