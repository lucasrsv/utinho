//
//  Uti.swift
//  Uti
//
//  Created by lrsv on 12/06/23.
//

import Foundation
import SwiftUI

struct Uti: Codable {
    var currentCycleDay: Int
    var phase: Phase
    var state: UtiState
    var leisure: Int
    var health: Int
    var nutrition: Int
    var blood: Int
    var items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case currentCycleDay = "current_cycle_day"
        case phase, state, leisure, health, nutrition, blood, items
    }
}

enum UtiState: Codable {
    case pissed
    case homely
    case sassy
    case bodybuilder
    case normal
    case sick
    case hungry
    case sleepy
}

enum Phase: Codable {
    case menstrual
    case folicular
    case fertile
    case luteal
    case pms
}
