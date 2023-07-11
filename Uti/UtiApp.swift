//
//  UtiApp.swift
//  Uti
//
//  Created by lrsv on 12/06/23.
//

import SwiftUI

@main
struct UtiApp: App {
    @StateObject private var utiStore = UtiStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(utiStore)
                .task {
                    do {
                        try await utiStore.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
