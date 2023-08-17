//
//  Responsive.swift
//  Uti
//
//  Created by michellyes on 17/08/23.
//

import Foundation
import SwiftUI

class Responsive {
    static func scale(s: Double) -> Double {
        s * UIScreen.main.bounds.width/390
    }
}
