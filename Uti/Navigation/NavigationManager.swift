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
    
    static var shared = NavigationManager()
    
    init() {
        if (isFirstTime == nil) {
            isFirstTime = false
            currentRoute = .onboarding
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
