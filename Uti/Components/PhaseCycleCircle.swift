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
                    .stroke(
                        Color.color.bege.opacity(0.42),
                        lineWidth: 10
                    )
                    .frame(width: 85, height: 85)
                Circle()
                    .trim(from: 0, to: (CGFloat(uti.currentCycleDay)/28))
                    .stroke(
                        Color.color.lightBlue,
                        style: StrokeStyle (
                            lineWidth: 10
                        )
                    )
                    .frame(width: 85, height: 85)
                    .rotationEffect(.degrees(-90))
                Text("\(uti.currentCycleDay)/28")
                    .bold()
                    .foregroundColor(.white)
            }
            Text(circleText())
                .foregroundColor(.white)
                .font(.system(size: 12, weight: .medium))
        }
    }
    
    func circleText() -> String {
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
