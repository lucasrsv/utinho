//
//  Uti.swift
//  Uti
//
//  Created by lrsv on 12/06/23.
//

import Foundation

struct Uti {
    var currentCycleDay: Int
    var phase: Phase
    var state: State
    var leisure: Int
    var health: Int
    var nutrition: Int
    var blood: Int
    var items: [Item]
}

enum State {
    case pissed
    case homely
    case sassy
    case bodybuilder
    case normal
    case sick
    case hungry
    case sleepy
}

enum Phase {
    case menstrual
    case folicular
    case fertile
    case luteal
    case pms
}
