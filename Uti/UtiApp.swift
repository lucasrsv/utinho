//
//  UtiApp.swift
//  Uti
//
//  Created by lrsv on 12/06/23.
//

import SwiftUI

@main
struct UtiApp: App {
    @StateObject private var store = UtiStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView(uti: $store.uti)
                .task {
                    do {
                        try await store.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
