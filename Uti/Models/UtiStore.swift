//
//  UtiStore.swift
//  Uti
//
//  Created by lrsv on 13/06/23.
//

import Foundation
import SwiftUI

class UtiStore: ObservableObject {
    @Published var uti: Uti = Uti(currentCycleDay: 1, phase: .menstrual, state: .homely, leisure: 100, health: 100, nutrition: 100, blood: 100, items: [])
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("uti.data")
    }
    
    func load() async throws {
        let task = Task<Uti, Error> {
            let fileURL = try Self.fileURL()
            let data = try Data(contentsOf: fileURL)
            let uti = try JSONDecoder().decode(Uti.self, from: data)
            return uti
        }
        let uti = try await task.value
        DispatchQueue.main.async {
            self.uti = uti
        }
    }
    
    func save(uti: Uti) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(uti)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
