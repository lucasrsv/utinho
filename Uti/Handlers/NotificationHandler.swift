//
//  NotificationHandler.swift
//  Uti
//
//  Created by michellyes on 06/09/23.
//

import Foundation
import UserNotifications

class NotificationHandler {
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("access granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification() {
        
    }
}
