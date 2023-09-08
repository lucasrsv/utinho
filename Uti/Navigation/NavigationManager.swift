//
//  NavigationManager.swift
//  Uti
//
//  Created by michellyes on 05/09/23.
//

import Foundation
import SwiftUI

class NavigationManager: ObservableObject {
    @Published var currentRoute: UtiRoute = .home
    @Published var routeHistory: [UtiRoute] = []
    @AppStorage("IsFirstTime") var isFirstTime: Bool?
    
    private let notificationManager = NotificationManager.shared
    
    init() {
        if (isFirstTime == nil) {
            isFirstTime = false
            currentRoute = .onboarding
            requestNotificationPermission()
        }
    }
    
    func navigate(to route: UtiRoute) {
        routeHistory.append(currentRoute)
        currentRoute = route
    }
    
    func navigateBack() {
        if let previousRoute = routeHistory.popLast() {
            currentRoute = previousRoute
        }
    }
    
    func requestNotificationPermission() {
        notificationManager.requestNotificationPermission { success, error in
            if success {
                self.notificationManager.scheduleDailyNotification()
            } else if let error = error {
                print("Erro ao solicitar permissão de notificação: \(error.localizedDescription)")
            }
        }
    }
    
    
}
