//
//  Uti.swift
//  Uti
//
//  Created by lrsv on 12/06/23.
//

import Foundation
import SwiftUI
import Combine

struct Uti: Codable {
    var currentCycleDay: Int
    var phase: Phase
    var state: UtiState
    var illness: Illness
    var leisure: Double
    var health: Double
    var nutrition: Double
    var energy: Double
    var blood: Double
    var items: [Item]

    var phasePublisher: AnyPublisher<Phase, Never> {
        return Just(phase)
            .eraseToAnyPublisher()
    }
    
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
            return(PhaseInfo.init(iconPath: "bloodDrop", previewDescription: "menstrual_popup_previewDescription", completeDescription: "menstrual_popup_completeDescription"))
        case .folicular:
            return(PhaseInfo.init(iconPath: "follicle", previewDescription: "folicular_popup_previewDescription", completeDescription: "folicular_popup_completeDescription"))
        case .fertile:
            return(PhaseInfo.init(iconPath: "ovule", previewDescription: "fertile_popup_previewDescription", completeDescription: "fertile_popup_completeDescription"))
        case .luteal:
            return(PhaseInfo.init(iconPath: "brick", previewDescription: "luteal_popup_previewDescription", completeDescription: "luteal_popup_completeDescription"))
        case .pms:
            return(PhaseInfo.init(iconPath: "storm", previewDescription: "pms_popup_previewDescription", completeDescription: "pms_popup_completeDescription"))
        }
    }
    
    static func phaseText(phase: Phase) -> String {
        switch (phase) {
        case .menstrual:
            return "cycleTitle_menstural"
        case .fertile:
            return "cycleTitle_folicular"
        case .folicular:
            return "cycleTitle_fertile"
        case .luteal:
            return "cycleTitle_luteal"
        case .pms:
            return "cycleTitle_pms"
        }
    }
}
