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
    @StateObject var navigationManager = NavigationManager()
    @AppStorage("IsFirstTime") var isFirstTime: Bool?
    
    init() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                NotificationManager.shared.scheduleDailyNotification()
            }
        }
    }
    
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
                        } catch {
                            fatalError(error.localizedDescription)
                        }
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
