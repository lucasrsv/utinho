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
    var illness: Illness
    var leisure: Int
    var health: Int
    var nutrition: Int
    var energy: Int
    var blood: Int
    var items: [Item]

    enum CodingKeys: String, CodingKey {
        case currentCycleDay = "current_cycle_day"
        case phase, state, leisure, health, nutrition, blood, items, illness, energy
    }
}

enum UtiState: String, Codable, CaseIterable {
    case pissed
    case pissedHappy
    case homelyHappy
    case homelySad
    case sassyGlass
    case sassyTattoo
    case bodybuilder
    case happy
    case sad
    case sickHpv
    case sickEndometriosis
    case hungry
    case sleepy
}

enum Phase: Codable, CaseIterable {
    case menstrual
    case folicular
    case fertile
    case luteal
    case pms
}

enum Illness: Codable, CaseIterable {
    case no
    case hpv
    case endometrios
}
