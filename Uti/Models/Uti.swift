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

struct PhaseInfo: Codable {
    var iconPath: String
    var previewDescription: String
    var completeDescription: String
}

extension Uti {
    static func getPhase(phase: Phase) -> PhaseInfo {
        switch phase {
        case .menstrual:
            return(PhaseInfo.init(iconPath: "bloodDrop", previewDescription: "At that moment, Uti's tissue begins to peel off (relax, it doesn't hurt too much). Some colic may arise. Be careful with him.", completeDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
        case .folicular:
            return(PhaseInfo.init(iconPath: "follicle", previewDescription: "Momento Body Builder! O Utinho está se preparando para o maior evento de todos (caso o óvulo seja fecundado). Suas camadas estão engrossando.", completeDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
        case .fertile:
            return(PhaseInfo.init(iconPath: "ovule", previewDescription: "Alerta! Agora o Utinho está todo saidinho. Após a liberação do óvulo, tome os cuidados para que uma gravidez indesejada não aconteça.", completeDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
        case .luteal:
            return(PhaseInfo.init(iconPath: "brick", previewDescription: "Está chegando o grande dia. O Utinho está começando a sentir os sinais. Suas camadas grossas estão se preparando para descamar.", completeDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
        case .pms:
            return(PhaseInfo.init(iconPath: "storm", previewDescription: "Agora quem tem que tomar cuidado é você! Com a menstruação chegando, se prepare para inchaços, estresses, irritações e alguns foras.", completeDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
        }
    }
    
    static func phaseText(phase: Phase) -> String {
        switch (phase) {
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
