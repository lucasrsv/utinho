//
//  swift
//  Uti
//
//  Created by lrsv on 13/06/23.
//

import Foundation
import SwiftUI

class UtiStore: ObservableObject {
    @Published var uti: Uti = Uti(currentCycleDay: 1, phase: .folicular, state: .homelyHappy, illness: .no, leisure: 100, health: 100, nutrition: 100, energy: 100, blood: 100, items: [])
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("uti.data")
    }
    
    func load() async throws {
        let task = Task<Uti, Error> {
               let fileURL = try Self.fileURL()
               let data = try Data(contentsOf: fileURL)
               let decoder = JSONDecoder()
               do {
                   let uti = try decoder.decode(Uti.self, from: data)
                   return uti
               } catch {
                   // TODO: handle this error
                   throw error
               }
           }
        let uti = try await task.value
        DispatchQueue.main.async {
            self.uti = uti
        }
    }
    
    func save() async {
        let task = Task {
            let data = try JSONEncoder().encode(uti)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        do {
            _ = try await task.value
        } catch {
            // TODO: handle this error
        }

    }
    
    func updateUtiPhase(elapsedTimeH: Int) { // 4 hours equals 1 day
        uti.currentCycleDay = (uti.currentCycleDay < 28) ? uti.currentCycleDay + elapsedTimeH/4 : 1 + (elapsedTimeH/4 - 1)
        if (uti.currentCycleDay <= 5) {
            uti.phase = .menstrual
        } else if (uti.currentCycleDay >= 6 && uti.currentCycleDay <= 11) {
            uti.phase = .folicular
        } else if (uti.currentCycleDay >= 12 && uti.currentCycleDay <= 16) {
            uti.phase = .fertile
        } else {
            uti.phase = .luteal
        }
    }
    
    func updateUtiStatistics(hoursSpent: Int) {
        uti.health = uti.health - (2 * hoursSpent)
        uti.leisure = uti.leisure - (3 * hoursSpent)
        uti.nutrition = uti.nutrition - (5 * hoursSpent)
    }
    
    func updateUtiState() {
        if (uti.illness != .no) {
            uti.state = .sickHpv
        } else if (uti.phase == .menstrual) {
            if (uti.health > 80) {
                uti.state = .homelyHappy
            } else {
                uti.state = .homelySad
            }
        } else if (uti.phase == .folicular) {
            if (uti.health < 50 || uti.leisure < 50) {
                uti.state = .sad
            } else if (uti.nutrition < 50) {
                uti.state = .hungry
            } else {
                uti.state = .happy
            }
        } else if (uti.phase == .fertile) {
            uti.state = .sassyGlass
        } else if (uti.phase == .luteal) {
            if (uti.health > 80 && uti.leisure > 80) {
                uti.state = .happy
            } else {
                uti.state = .sad
            }
        } else if (uti.phase == .pms) {
            if (uti.health < 50) {
                uti.state = .pissed
            } else if (uti.leisure > 90) {
                uti.state = .pissedHappy
            }
        }
    }
    
    func giveUtiItem(item: Item) {
        switch (item.name) {
        case .spaDay:
            switch (uti.phase) {
            case .menstrual:
                uti.leisure = uti.leisure + 5
            case .folicular:
                uti.leisure = uti.leisure + 10
            case .fertile:
                uti.leisure = uti.leisure + 10
            case .luteal:
                uti.leisure = uti.leisure + 10
            case .pms:
                uti.leisure = uti.leisure + 10
            }
        case .book:
            switch (uti.phase) {
            case .menstrual:
                uti.leisure = uti.leisure + 10
            case .folicular:
                uti.leisure = uti.leisure + 10
            case .fertile:
                uti.leisure = uti.leisure + 10
            case .luteal:
                uti.leisure = uti.leisure + 10
            case .pms:
                uti.leisure = uti.leisure + 10
            }
        case .games:
            switch (uti.phase) {
            case .menstrual:
                uti.leisure = uti.leisure + 5
            case .folicular:
                uti.leisure = uti.leisure + 10
            case .fertile:
                uti.leisure = uti.leisure + 10
            case .luteal:
                uti.leisure = uti.leisure + 10
            case .pms:
                uti.leisure = uti.leisure + 5
            }
        case .netflix:
            switch (uti.phase) {
            case .menstrual:
                uti.leisure = uti.leisure + 5
            case .folicular:
                uti.leisure = uti.leisure + 10
            case .fertile:
                uti.leisure = uti.leisure + 10
            case .luteal:
                uti.leisure = uti.leisure + 10
            case .pms:
                uti.leisure = uti.leisure + 5
            }
        case .chocolate:
            switch (uti.phase) {
            case .menstrual:
                uti.health = uti.health - 10
                uti.nutrition = uti.nutrition + 10
                uti.leisure = uti.leisure + 10
            case .folicular:
                uti.leisure = uti.leisure + 5
                uti.nutrition = uti.nutrition + 10
            case .fertile:
                uti.leisure = uti.leisure + 5
                uti.nutrition = uti.nutrition + 10
            case .luteal:
                uti.leisure = uti.leisure + 5
                uti.nutrition = uti.nutrition + 10
            case .pms:
                uti.leisure = uti.leisure + 5
                uti.nutrition = uti.nutrition + 10
            }
        case .coffe:
            switch (uti.phase) {
            case .menstrual:
                uti.health = uti.health - 10
                uti.nutrition = uti.nutrition + 10
                uti.energy = uti.energy + 20
            case .folicular:
                uti.health = uti.health - 5
                uti.nutrition = uti.nutrition + 10
                uti.energy = uti.energy + 20
            case .fertile:
                uti.health = uti.health - 5
                uti.nutrition = uti.nutrition + 10
                uti.energy = uti.energy + 20
            case .luteal:
                uti.health = uti.health - 5
                uti.nutrition = uti.nutrition + 10
                uti.energy = uti.energy + 20
            case .pms:
                uti.health = uti.health - 10
                uti.nutrition = uti.nutrition + 10
                uti.energy = uti.energy + 20
            }
        case .cupNoodles:
            uti.health = uti.health - 5
            uti.nutrition = uti.nutrition + 10
        case .banana:
            uti.health = uti.health + 5
            uti.nutrition = uti.nutrition + 10
        case .avocado:
            uti.health = uti.health + 5
            uti.nutrition = uti.nutrition + 10
        case .xuxi:
            uti.health = uti.health + 5
            uti.nutrition = uti.nutrition + 10
            uti.leisure = uti.leisure + 10
        case .contraceptive:
            if (uti.currentCycleDay == 1) {
                uti.health = uti.health + 20
            } else {
                uti.health = uti.health - 10
            }
        case .pill:
            // TODO: add health at the first time its being used in the month
            uti.health = uti.health
        case .condom:
            // TODO: add leisure if the user go to the party
            uti.health = uti.health + 10
        case .medicineColic:
            if (uti.phase == .menstrual) {
                uti.health = uti.health + 10
            }
        case .warmCompress:
            if (uti.phase == .menstrual) {
                uti.health = uti.health + 10
            }
        case .absorbent:
            if (uti.phase == .menstrual) {
                uti.health = uti.health + 10
            }
        case .collector:
            if (uti.phase == .menstrual) {
                uti.health = uti.health + 10
            }
        case .absorbentPanties:
            if (uti.phase == .menstrual) {
                uti.health = uti.health + 10
            }
        }
        
        // TODO: this shouldn't be needed
        if (uti.health > 100) {
            uti.health = 100
        }
        if (uti.energy > 100) {
            uti.energy = 100
        }
        if (uti.leisure > 100) {
            uti.leisure = 100
        }
        if (uti.nutrition > 100) {
            uti.nutrition = 100
        }
    }
}
