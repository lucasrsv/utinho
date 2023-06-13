//
//  UtiStore.swift
//  Uti
//
//  Created by lrsv on 13/06/23.
//

import Foundation
import SwiftUI

class UtiStore: ObservableObject {
    @Published var uti: Uti
    
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("uti.data")
    }
}
