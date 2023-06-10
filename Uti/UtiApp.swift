//
//  UtiApp.swift
//  Uti
//
//  Created by bamcc on 10/06/23.
//

import SwiftUI

@main
struct UtiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
