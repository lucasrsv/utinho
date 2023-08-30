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
    @AppStorage("IsFirstTime") var isFirstTime = true
    
    var body: some Scene {
        WindowGroup {
            OnboardingOne()
        }
//        WindowGroup {
//            ContentView()
//                .environmentObject(utiStore)
//                .task {
//                    do {
//                        if (isFirstTime) {
//                            await utiStore.save()
//                            isFirstTime = false
//                        }
//                        try await utiStore.load()
//                    } catch {
//                        fatalError(error.localizedDescription)
//                    }
//                }
//        }
        
    }
}
