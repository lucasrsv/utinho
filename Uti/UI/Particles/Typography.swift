//
//  Typography.swift
//  Uti
//
//  Created by lrsv on 04/08/23.
//

import Foundation
import SwiftUI

enum FontSize: CGFloat {
    case caption = 12
    case body = 14
    case h3 = 18
    case h2 = 24
    case h1 = 28
}

enum FontWeight {
    case bold
    case semibold
    case medium
    
    var value: Font.Weight {
        switch self {
            case .bold: return .bold
            case .semibold: return .semibold
            case .medium: return .medium
        }
    }
}
