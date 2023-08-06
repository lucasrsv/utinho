//
//  Body.swift
//  Uti
//
//  Created by lrsv on 04/08/23.
//

import Foundation
import SwiftUI

// This is just a sample. It probably won't be needed, as we have a simple design system
struct Body: View {
    let text: String
    let fontWeight: BodyFontWeight
    
    var body: some View {
        Text(text)
            .font(.system(size: FontSize.body.rawValue, weight: fontWeight.value))
    }
}

enum BodyFontWeight {
    case medium(FontWeight)
    case semibold(FontWeight)
    
    var value: Font.Weight {
        switch self {
        case .medium: return .medium
        case .semibold: return .semibold
        }
    }
}
