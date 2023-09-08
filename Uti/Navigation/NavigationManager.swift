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
    
    private let notificationManager : NotificationManager
    
    init (notificationManager : NotificationManager) {
        self.notificationManager = notificationManager
    }
    
    init() {
        if (isFirstTime == nil) {
            isFirstTime = false
            currentRoute = .onboarding
            notificationManager.requestNotificationPermission()
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
    
    
}
