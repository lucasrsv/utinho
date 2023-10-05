//
//  swift
//  Uti
//
//  Created by lrsv on 13/06/23.
//

import Foundation
import SwiftUI

class UtiStore: ObservableObject {
    @Published var uti: Uti = Uti(currentCycleDay: 1, phase: .folicular, state: .homelyHappy, illness: .no, leisure: 50, health: 60, nutrition: 55, energy: 100, blood: 100, items: []) {
        didSet {
            Task {
                await save()
            }
        }
    }
    
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
    
    func updateUtiPhase(elapsedDays: Int) { // 4 hours equals 1 day
        NSLog("UTINHOLOG: uti.currentCycleDay \(uti.currentCycleDay)")
        uti.currentCycleDay = uti.currentCycleDay + elapsedDays
        NSLog("UTINHOLOG: uti.currentCycleDay updated \(uti.currentCycleDay)")
        NSLog("UTINHOLOG: elapsedDays \(elapsedDays)")
        if (uti.currentCycleDay > 28) {
            uti.currentCycleDay = uti.currentCycleDay % 28
            NSLog("UTINHOLOG: uti.currentCycleDay module \(uti.currentCycleDay)")
        }
        
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
    
    func updateUtiStatistics(hoursSpent: Double) {
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
    
    func giveUtiItem(item: Item) -> String {
        var itemValue = ""
        
        switch (item.name) {
            // MARK: HEALTH
        case .contraceptive:
            uti.health = uti.health
        case .pill:
            // TODO: add health at the first time its being used in the month
            uti.health = uti.health
        case .condom:
            // TODO: add leisure if the user go to the party
            uti.health = uti.health + 10
            itemValue = "+10"
        case .medicineColic:
            if (uti.phase == .menstrual) {
                uti.health = uti.health + 10
                itemValue = "+10"
            }
        case .warmCompress:
            if (uti.phase == .menstrual) {
                uti.health = uti.health + 10
                itemValue = "+10"
            }
        case .absorbent:
            if (uti.phase == .menstrual) {
                uti.health = uti.health + 10
                itemValue = "+10"
            }
        case .collector:
            if (uti.phase == .menstrual) {
                uti.health = uti.health + 10
                itemValue = "+10"
            }
        case .absorbentPanties:
            if (uti.phase == .menstrual) {
                uti.health = uti.health + 10
                itemValue = "+10"
            }
            
            // MARK: NUTRITION
        case .water:
            uti.health = uti.health + 10
            uti.nutrition = uti.nutrition + 10
            itemValue = "+20"
        case .tea:
            uti.health = uti.health + 10
            uti.nutrition = uti.nutrition + 9
            uti.leisure = uti.leisure + 3
            itemValue = "+22"
        case .chocolate:
            switch (uti.phase) {
            case .menstrual:
                uti.leisure = uti.leisure + 10
                uti.nutrition = uti.nutrition + 5
                itemValue = "+15"
            case .folicular:
                uti.leisure = uti.leisure + 10
                uti.nutrition = uti.nutrition + 5
                itemValue = "+15"
            case .fertile:
                uti.leisure = uti.leisure + 10
                uti.nutrition = uti.nutrition + 5
                itemValue = "+15"
            case .luteal:
                uti.leisure = uti.leisure + 10
                uti.nutrition = uti.nutrition + 5
                itemValue = "+15"
            case .pms:
                uti.leisure = uti.leisure + 10
                uti.nutrition = uti.nutrition + 5
                itemValue = "+15"
            }
        case .soda: // reviewed
            switch (uti.phase) {
            case .menstrual:
                uti.health = uti.health - 20
                uti.nutrition = uti.nutrition - 15
                uti.leisure = uti.leisure + 10
                itemValue = "-25"
            case .folicular:
                uti.health = uti.health - 10
                uti.nutrition = uti.nutrition - 10
                uti.leisure = uti.leisure + 5
                itemValue = "-15"
            case .fertile:
                uti.health = uti.health - 10
                uti.nutrition = uti.nutrition - 10
                uti.leisure = uti.leisure + 5
                itemValue = "-15"
            case .luteal:
                uti.health = uti.health - 10
                uti.nutrition = uti.nutrition - 10
                uti.leisure = uti.leisure + 5
                itemValue = "-15"
            case .pms:
                uti.health = uti.health - 20
                uti.nutrition = uti.nutrition - 15
                uti.leisure = uti.leisure + 10
                itemValue = "-25"
            }
        case .cupNoodles: // reviewed
            uti.health = uti.health - 10
            uti.nutrition = uti.nutrition + 2
            uti.leisure = uti.leisure + 5
            itemValue = "-10"
        case .banana: // reviewed
            uti.health = uti.health + 5
            uti.nutrition = uti.nutrition + 10
            itemValue = "+15"
        case .redMeat: // reviewed
            switch (uti.phase) {
            case .menstrual:
                uti.health = uti.health - 15
                uti.nutrition = uti.nutrition + 5
                uti.leisure = uti.leisure + 5
                itemValue = "-5"
            case .folicular:
                uti.health = uti.health + 3
                uti.nutrition = uti.nutrition + 5
                uti.leisure = uti.leisure + 5
                itemValue = "+13"
            case .fertile:
                uti.health = uti.health + 3
                uti.nutrition = uti.nutrition + 5
                uti.leisure = uti.leisure + 5
                itemValue = "+13"
            case .luteal:
                uti.health = uti.health + 2
                uti.nutrition = uti.nutrition + 5
                uti.leisure = uti.leisure + 5
                itemValue = "+12"
            case .pms:
                uti.health = uti.health - 15
                uti.nutrition = uti.nutrition + 5
                uti.energy = uti.energy + 5
                itemValue = "-5"
            }
        case .sushi: // reviewed
            uti.health = uti.health + 5
            uti.nutrition = uti.nutrition + 10
            uti.leisure = uti.leisure + 15
            itemValue = "+30"
            
            // MARK: LEISURE
        case .spaDay:
            if (uti.phase == .menstrual || uti.phase == .pms) {
                uti.leisure = uti.leisure + 12
                itemValue = "+12"
            } else {
                uti.leisure = uti.leisure + 10
                itemValue = "+10"
            }
        case .book:
            uti.leisure = uti.leisure + 10
            itemValue = "+10"
        case .games:
            uti.leisure = uti.leisure + 6
            itemValue = "+6"
        case .movieNight:
            uti.leisure = uti.leisure + 9
            itemValue = "+9"
        case .gym:
            if (uti.phase == .menstrual || uti.phase == .pms) {
                uti.health = uti.health - 10
                uti.leisure = uti.leisure + 7
                itemValue = "-3"
            } else {
                uti.health = uti.health + 10
                uti.leisure = uti.leisure + 8
                itemValue = "+18"
            }
        case .party:
            if (uti.phase == .menstrual || uti.phase == .pms) {
                uti.health = uti.health - 10
                uti.leisure = uti.leisure + 10
                itemValue = "-10"
            } else {
                uti.leisure = uti.leisure + 10
                itemValue = "+10"
            }
        case .dateNight:
            if (uti.phase == .fertile) {
                uti.leisure = uti.leisure + 20
                itemValue = "+20"
            } else if (uti.phase == .menstrual || uti.phase == .pms) {
                uti.health = uti.health - 5
                uti.leisure = uti.leisure + 10
                itemValue = "+5"
            } else {
                uti.leisure = uti.leisure + 10
                itemValue = "+10"
            }
        case .bike:
            if (uti.phase == .menstrual || uti.phase == .pms) {
                uti.health = uti.health + 6
                uti.leisure = uti.leisure + 5
                itemValue = "+11"
            } else {
                uti.health = uti.health + 8
                uti.leisure = uti.leisure + 5
                itemValue = "+13"
            }
            
        }
        
        // TODO: this shouldn't be needed
        if (uti.health > 100) {
            uti.health = 100
        } else if (uti.health < 0) {
            uti.health = 0
        }
        
        if (uti.energy > 100) {
            uti.energy = 100
        } else if (uti.energy < 0) {
            uti.energy = 0
        }
        
        if (uti.leisure > 100) {
            uti.leisure = 100
        } else if (uti.leisure < 0) {
            uti.leisure = 0
        }
        
        if (uti.nutrition > 100) {
            uti.nutrition = 100
        } else if (uti.nutrition < 0) {
            uti.nutrition = 0
        }
        
        return itemValue
    }
}
