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
    @StateObject private var navigationManager = NavigationManager()
    @StateObject private var timerManager: TimerManager = TimerManager()
    @AppStorage("IsFirstTime") private var isFirstTime: Bool?
    @State private var notificationManager: NotificationManager?
    
    var body: some Scene {
        WindowGroup {
            switch navigationManager.currentRoute {
            case .home:
                ContentView()
                    .environmentObject(utiStore)
                    .environmentObject(navigationManager)
                    .task {
                        do {
                            try await utiStore.load()
                            timerManager.setup(utiStore: utiStore)
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    }
                    .onAppear {
                        notificationManager = NotificationManager(uti: utiStore.uti)
                    }
            case .onboarding:
                OnboardingView()
                    .environmentObject(utiStore)
                    .environmentObject(navigationManager)
                    .task {
                        await utiStore.save()
                    }
            case .minigame1:
                ContentView()
            case .minigame2:
                ContentView()
                
            }
        }
    }
}
